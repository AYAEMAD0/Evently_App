import 'package:evently_app/data/mappers/user_model_dto_mapper.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repo/profile_repo.dart';
import '../data_sources/local/profile_local_data_source.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileLocalDataSource profileLocalDataSource;
  ProfileRepoImpl({required this.profileLocalDataSource});

  @override
  Future<UserEntity> getUserProfile() async {
    try {
      final user = await profileLocalDataSource.getCachedUser();
      return user.toUserEntity();
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

}