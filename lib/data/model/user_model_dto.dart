import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModelDto {
  static final String collectionName = 'User';
  final String id;
  final String name;
  final String email;
  final String avatarId;

  UserModelDto({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarId,
  });

  UserModelDto.fromFirebase(Map<String, dynamic> json)
    : this(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        avatarId: json['avatarId'] as String,
      );

  Map<String, dynamic> toFirebase() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatarId": avatarId,
    };
  }
  factory UserModelDto.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserModelDto(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      avatarId: firebaseUser.photoURL??'',
    );
  }
}
