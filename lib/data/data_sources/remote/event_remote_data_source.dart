import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../main.dart';
import '../../model/event_model_dto.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../model/user_model_dto.dart';

@injectable
class EventRemoteDataSource {
  CollectionReference<EventModelDto> getCollection(String uid) {
    return FirebaseFirestore.instance
        .collection(UserModelDto.collectionName).doc(uid)
        .collection(EventModelDto.collectionName)
        .withConverter<EventModelDto>(
          fromFirestore: (snap, _) => EventModelDto.fromFirestore(snap.data()!),
          toFirestore: (event, _) => event.toFirestore(),
        );
  }

  Future<void> addEvent(EventModelDto dto,String uid) async {
    final doc = getCollection(uid).doc();
    dto.id = doc.id;
    await doc.set(dto);
    await scheduleEventNotification(dto);
  }

  Future<List<EventModelDto>> getEventsByCategory(String category,String uid) async {
    try {
      final snapshot = await getCollection(uid)
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

  Future<List<EventModelDto>> getAllEvents(String uid) async {
    try {
      final snapshot = await getCollection(uid).orderBy("date").get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to get all events: ${e.toString()}');
    }
  }

  Future<void> deleteEvent(EventModelDto dto,String uid) async {
    if (dto.id == null || dto.id!.isEmpty) {
      throw Exception('Event ID is null or empty. Cannot delete the event.');
    }
    try {
      await getCollection(uid).doc(dto.id).delete();
    } catch (e) {
      throw Exception('Failed to delete event: ${e.toString()}');
    }
  }

  Future<void> editEvent(EventModelDto dto,String uid) async {
    if (dto.id == null || dto.id!.isEmpty) {
      throw Exception('Event ID is null or empty. Cannot edit the event.');
    }
    try {
      await getCollection(uid).doc(dto.id).update(dto.toFirestore());
    } catch (e) {
      throw Exception('Failed to edit event: ${e.toString()}');
    }
  }

  Future<List<EventModelDto>> getAllFavEvents(String uid) async {
    try {
      final snapshot = await getCollection(uid)
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

  Future<void> changeFavEvent(String eventId, bool isFavourite,String uid) async {
    if (eventId.isEmpty) {
      throw Exception('Event ID is empty. Cannot change favorite status.');
    }
    try {
      await getCollection(uid).doc(eventId).update({'isFavourite': isFavourite});
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
