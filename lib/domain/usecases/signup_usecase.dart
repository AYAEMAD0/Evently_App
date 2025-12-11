import 'package:evently_app/domain/entities/user_model.dart';
import 'package:injectable/injectable.dart';
import '../repo/auth_repo.dart';

@injectable
class SignupUseCase{
  AuthRepo authRepo;
  SignupUseCase({required this.authRepo});

  Future<UserModel>call({required String email,required String password,required String name}){
    return authRepo.signup(email: email,password:  password,name: name);
  }
}