import '../entities/user_model.dart';

abstract class AuthRepo{
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> loginWithGoogle();
  Future<UserModel> signup({required String name, required String email,required String password});
  Future<void> forgetPassword({required String email,});
}