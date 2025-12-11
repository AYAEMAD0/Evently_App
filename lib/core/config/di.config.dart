// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sourses/remote/auth_remote_data_source.dart' as _i72;
import '../../data/firebase_module.dart' as _i788;
import '../../data/repo_impl/auth_repo_impl.dart' as _i540;
import '../../domain/repo/auth_repo.dart' as _i716;
import '../../domain/usecases/forget_password_usecase.dart' as _i25;
import '../../domain/usecases/login_usecase.dart' as _i253;
import '../../domain/usecases/login_with_google_usecase.dart' as _i578;
import '../../domain/usecases/signup_usecase.dart' as _i866;
import '../../features/auth/viewmodel/forget_password/forget_password_cubit.dart'
    as _i447;
import '../../features/auth/viewmodel/login/login_cubit.dart' as _i131;
import '../../features/auth/viewmodel/signup/signup_cubit.dart' as _i776;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.factory<_i72.AuthRemoteDataSource>(
      () => _i72.AuthRemoteDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.factory<_i716.AuthRepo>(
      () => _i540.AuthRepoImpl(
        authRemoteDataSource: gh<_i72.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i25.ForgetPasswordUseCase>(
      () => _i25.ForgetPasswordUseCase(authRepo: gh<_i716.AuthRepo>()),
    );
    gh.factory<_i253.LoginUseCase>(
      () => _i253.LoginUseCase(authRepo: gh<_i716.AuthRepo>()),
    );
    gh.factory<_i578.LoginWithGoogleUseCase>(
      () => _i578.LoginWithGoogleUseCase(authRepo: gh<_i716.AuthRepo>()),
    );
    gh.factory<_i866.SignupUseCase>(
      () => _i866.SignupUseCase(authRepo: gh<_i716.AuthRepo>()),
    );
    gh.factory<_i447.ForgetPasswordCubit>(
      () => _i447.ForgetPasswordCubit(
        forgetPasswordUseCase: gh<_i25.ForgetPasswordUseCase>(),
      ),
    );
    gh.factory<_i776.SignupCubit>(
      () => _i776.SignupCubit(signupUseCase: gh<_i866.SignupUseCase>()),
    );
    gh.factory<_i131.LoginCubit>(
      () => _i131.LoginCubit(
        loginUseCase: gh<_i253.LoginUseCase>(),
        loginWithGoogleUseCase: gh<_i578.LoginWithGoogleUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i788.FirebaseModule {}
