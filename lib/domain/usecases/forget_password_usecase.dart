import 'package:injectable/injectable.dart';
import '../repo/auth_repo.dart';

@injectable
class ForgetPasswordUseCase{
  AuthRepo authRepo;
  ForgetPasswordUseCase({required this.authRepo});

  Future<void>call({required String email}){
    return authRepo.forgetPassword(email: email);
  }
}