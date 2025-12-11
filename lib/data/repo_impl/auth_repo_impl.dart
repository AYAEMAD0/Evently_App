import 'package:evently_app/data/data_sourses/remote/auth_remote_data_source.dart';
import 'package:evently_app/domain/entities/user_model.dart';
import 'package:evently_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<void> forgetPassword({required String email}) {
    return authRemoteDataSource.forgetPassword(email:email);
  }

  @override
  Future<UserModel> login({required String email,required String password}) async {
    final userCredential = await authRemoteDataSource.login(email:email,password: password);
    final user = userCredential.user!;
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  @override
  Future<UserModel> signup({required String name,required String email,required String password}) async {
    final userCredential = await authRemoteDataSource.signup(email: email,password:  password);
    final user = userCredential.user!;
    await user.updateDisplayName(name);
    return UserModel(
      id: user.uid,
      name: name,
      email: user.email ?? '',
    );
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    final userCredential = await authRemoteDataSource.signInWithGoogle();
    final user = userCredential.user!;

    if (!user.emailVerified) {
      throw Exception("Please verify your email first");
    }
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }
}
