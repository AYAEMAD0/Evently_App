import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../model/user_model_dto.dart';

@injectable
class UserRemoteDataSource {
  CollectionReference<UserModelDto> getCollection() {
    return FirebaseFirestore.instance
        .collection(UserModelDto.collectionName)
        .withConverter<UserModelDto>(
      fromFirestore: (snap, _) =>
          UserModelDto.fromFirebase(snap.data()!),
      toFirestore: (user, _) => user.toFirebase(),
    );
  }

  Future<void> createUser(UserModelDto user) async {
    final doc = await getCollection().doc(user.id).get();
    if (!doc.exists) {
      await getCollection().doc(user.id).set(user);
    }
  }


  Future<UserModelDto?> getUser(String uid) async {
    final doc = await getCollection().doc(uid).get();
    return doc.data();
  }
}
