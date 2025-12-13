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
          .get();
      if (snapshot.docs.isEmpty) {
        return [];
      }
      return snapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      throw Exception('Failed to get events by category: ${e.toString()}');
    }
  }


  Future<List<EventModelDto>> getAllEvents() async {
    try {
      final snapshot = await getCollection().get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      throw Exception('Failed to get all events: ${e.toString()}');
    }
  }
}