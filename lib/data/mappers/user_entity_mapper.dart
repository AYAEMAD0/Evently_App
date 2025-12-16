import 'package:evently_app/data/model/user_model_dto.dart';
import 'package:evently_app/domain/entities/user_entity.dart';

extension UserEntityMapper on UserEntity {
  UserModelDto toUserModelDto() {
    return UserModelDto(
        id: id,
        email: email,
        name: name,
        avatarId: avatarId??'0'
    );
  }
}
