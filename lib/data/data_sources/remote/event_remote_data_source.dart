import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../main.dart';
import '../../model/event_model_dto.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@injectable
class EventRemoteDataSource {
  CollectionReference<EventModelDto> getCollection() {
    return FirebaseFirestore.instance
        .collection(EventModelDto.collectionName)
        .withConverter<EventModelDto>(
          fromFirestore: (snap, _) => EventModelDto.fromFirestore(snap.data()!),
          toFirestore: (event, _) => event.toFirestore(),
        );
  }

  Future<void> addEvent(EventModelDto dto) async {
    final doc = getCollection().doc();
    dto.id = doc.id;
    await doc.set(dto);
    await scheduleEventNotification(dto);
  }

  Future<List<EventModelDto>> getEventsByCategory(String category) async {
    try {
      final snapshot = await getCollection()
          .where('category', isEqualTo: category)
          .orderBy("date")
          .get();
      if (snapshot.docs.isEmpty) {
        return [];
      }
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to get events by category: ${e.toString()}');
    }
  }

  Future<List<EventModelDto>> getAllEvents() async {
    try {
      final snapshot = await getCollection().orderBy("date").get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to get all events: ${e.toString()}');
    }
  }

  Future<void> deleteEvent(EventModelDto dto) async {
    if (dto.id == null || dto.id!.isEmpty) {
      throw Exception('Event ID is null or empty. Cannot delete the event.');
    }
    try {
      await getCollection().doc(dto.id).delete();
    } catch (e) {
      throw Exception('Failed to delete event: ${e.toString()}');
    }
  }

  Future<void> editEvent(EventModelDto dto) async {
    if (dto.id == null || dto.id!.isEmpty) {
      throw Exception('Event ID is null or empty. Cannot edit the event.');
    }
    try {
      await getCollection().doc(dto.id).update(dto.toFirestore());
    } catch (e) {
      throw Exception('Failed to edit event: ${e.toString()}');
    }
  }

  Future<List<EventModelDto>> getAllFavEvents() async {
    try {
      final snapshot = await getCollection()
          .where("isFavourite", isEqualTo: true)
          .orderBy("date")
          .get();
      if (snapshot.docs.isEmpty) {
        return [];
      }
      return snapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      throw Exception('Failed to get all fav events: ${e.toString()}');
    }
  }

  Future<void> changeFavEvent(String eventId, bool isFavourite) async {
    if (eventId.isEmpty) {
      throw Exception('Event ID is empty. Cannot change favorite status.');
    }
    try {
      await getCollection().doc(eventId).update({'isFavourite': isFavourite});
    } catch (e) {
      throw Exception('Failed to change favorite status: ${e.toString()}');
    }
  }

  Future<void> scheduleEventNotification(EventModelDto dto) async {
    final parts = dto.time.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final eventDateTime = DateTime(
      dto.date.year,
      dto.date.month,
      dto.date.day,
      hour,
      minute,
    );

    final now = DateTime.now();
    final difference = eventDateTime.difference(now);

    if (difference.isNegative) {
      debugPrint('Notification time is in the past');
      return;
    }

    Future.delayed(difference, () async {
      await flutterLocalNotificationsPlugin.show(
        dto.id.hashCode,
        dto.title,
        dto.description,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'event_channel',
            'Event Notifications',
            channelDescription: 'Notifications for events',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    });
  }

}
