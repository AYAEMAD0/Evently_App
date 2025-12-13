import 'package:evently_app/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginUseCase{
  AuthRepo authRepo;
  LoginUseCase({required this.authRepo});

  Future<UserEntity>call({required String email,required String password}){
    return authRepo.login(email: email,password:  password);
  }
}