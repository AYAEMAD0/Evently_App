import '../entities/user_entity.dart';

abstract class AuthRepo{
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> signup({required String name, required String email,required String password});
  Future<void> forgetPassword({required String email,});
}