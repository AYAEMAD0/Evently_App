import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../model/event_model_dto.dart';

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
          .where("isFavourite", isEqualTo: true).orderBy("date")
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
      await getCollection().doc(eventId).update({
        'isFavourite': isFavourite,
      });
    } catch (e) {
      throw Exception('Failed to change favorite status: ${e.toString()}');
    }
  }

}
