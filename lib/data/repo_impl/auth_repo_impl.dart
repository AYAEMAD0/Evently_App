import 'package:evently_app/domain/entities/user_entity.dart';
import 'package:evently_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<void> forgetPassword({required String email}) {
    return authRemoteDataSource.forgetPassword(email:email);
  }

  @override
  Future<UserEntity> login({required String email,required String password}) async {
    final userCredential = await authRemoteDataSource.login(email:email,password: password);
    final user = userCredential.user!;
    return UserEntity(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  @override
  Future<UserEntity> signup({required String name,required String email,required String password}) async {
    final userCredential = await authRemoteDataSource.signup(email: email,password:  password);
    final user = userCredential.user!;
    await user.updateDisplayName(name);
    return UserEntity(
      id: user.uid,
      name: name,
      email: user.email ?? '',
    );
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    final userCredential = await authRemoteDataSource.signInWithGoogle();
    final user = userCredential.user!;

    if (!user.emailVerified) {
      throw Exception("Please verify your email first");
    }
    return UserEntity(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }
}
