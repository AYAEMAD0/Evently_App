class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? avatarId;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
     this.avatarId,
  });
}
