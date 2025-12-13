import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../model/event_model_dto.dart';

@injectable
class EventRemoteDataSource {
  CollectionReference<EventModelDto> getCollection() {
    return FirebaseFirestore.instance
        .collection(EventModelDto.collectionName)
        .withConverter<EventModelDto>(
      fromFirestore: (snap, _) =>
          EventModelDto.fromFirestore(snap.data()!),
      toFirestore: (event, _) => event.toFirestore(),
    );
  }

  Future<void> addEvent(EventModelDto dto) async {
    final doc = getCollection().doc();
    dto.id = doc.id;
    await doc.set(dto);
  }

  Future<EventModelDto?> getEvent(String id) async {
    final snapshot = await getCollection().doc(id).get();
    return snapshot.data();
  }
}
