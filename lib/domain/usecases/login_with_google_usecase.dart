import 'package:evently_app/domain/entities/user_model.dart';
import 'package:injectable/injectable.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginWithGoogleUseCase{
  AuthRepo authRepo;
  LoginWithGoogleUseCase({required this.authRepo});

  Future<UserModel>call(){
    return authRepo.loginWithGoogle();
  }
}