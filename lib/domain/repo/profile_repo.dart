import '../entities/user_entity.dart';

abstract class ProfileRepo{
  Future<UserEntity> getUserProfile();
}