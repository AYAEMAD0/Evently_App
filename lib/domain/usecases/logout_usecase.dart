import 'package:evently_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  Future<void> call() async {
    return await authRepo.logout();
  }
}