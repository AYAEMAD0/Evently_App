import 'package:evently_app/data/model/user_model_dto.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/helper/shared_check_helper.dart';

@injectable
class ProfileLocalDataSource {

  Future<UserModelDto> getCachedUser() async {
    final userData = SharedCheckHelper.getUserData();

    if (userData['id'] == null || userData['id']!.isEmpty) {
      throw Exception('No cached user found');
    }
    return UserModelDto(
      id: userData['id']!,
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      avatarId: userData['avatarId'] ?? '',
    );
  }
}
