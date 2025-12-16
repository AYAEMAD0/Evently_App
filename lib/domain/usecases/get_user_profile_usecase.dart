import 'package:injectable/injectable.dart';
import '../entities/user_entity.dart';
import '../repo/profile_repo.dart';

@injectable
class GetUserProfileUseCase {
  final ProfileRepo profileRepo;

  GetUserProfileUseCase(this.profileRepo);

  Future<UserEntity> call() async {
    return await profileRepo.getUserProfile();
  }
}