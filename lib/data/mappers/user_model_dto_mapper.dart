import 'package:evently_app/data/model/user_model_dto.dart';
import 'package:evently_app/domain/entities/user_entity.dart';

extension UserModelDtoMapper on UserModelDto {
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      avatarId: avatarId
    );
  }
}
