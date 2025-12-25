import 'package:evently_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:evently_app/data/mappers/user_model_dto_mapper.dart';
import 'package:evently_app/domain/entities/user_entity.dart';
import 'package:evently_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../../core/helper/shared_check_helper.dart';
import '../data_sources/remote/auth_remote_data_source.dart';
import '../model/user_model_dto.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  AuthRepoImpl({required this.authRemoteDataSource,required this.userRemoteDataSource});

  @override
  Future<void> forgetPassword({required String email}) {
    return authRemoteDataSource.forgetPassword(email: email);
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await authRemoteDataSource.login(
        email: email,
        password: password,
      );

      final user = UserModelDto.fromFirebaseUser(userCredential.user!);
      await SharedCheckHelper.setUserData(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarId: user.avatarId,
      );
      await SharedCheckHelper.setValue(SharedCheckHelper.keyIsLogin,true);
      return user.toUserEntity();
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
    String? avatarId,
  }) async {
    try {
      final userCredential = await authRemoteDataSource.signup(
        email: email,
        password: password,
        name: name,
        avatarId: avatarId,
      );
      final userDto =
      UserModelDto.fromFirebaseUser(userCredential.user!);
      await userRemoteDataSource.createUser(userDto);

      final user = UserModelDto.fromFirebaseUser(userCredential.user!);
      await SharedCheckHelper.setUserData(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarId: user.avatarId,
      );
      await SharedCheckHelper.setValue(SharedCheckHelper.keyIsLogin,true);
      return user.toUserEntity();
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    final userCredential = await authRemoteDataSource.signInWithGoogle();
    final user = userCredential.user!;

    await SharedCheckHelper.setUserData(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      avatarId: user.photoURL ?? '',
    );
    await SharedCheckHelper.setValue(SharedCheckHelper.keyIsLogin, true);

    return UserEntity(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      avatarId: user.photoURL ?? '',
    );
  }

  @override
  Future<void> logout() async {
    try {
      await authRemoteDataSource.logout();
      await SharedCheckHelper.clearUserData();
      await SharedCheckHelper.setValue(SharedCheckHelper.keyIsLogin,false);
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}