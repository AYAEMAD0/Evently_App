class UserModelDto {
  static final String collectionName = 'User';
  final String id;
  final String name;
  final String email;

  UserModelDto({
    required this.id,
    required this.name,
    required this.email,
  });

  UserModelDto.fromFirebase(Map<String, dynamic> json)
    : this(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toFirebase() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
