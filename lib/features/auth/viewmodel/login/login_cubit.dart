import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/usecases/login_usecase.dart';
import 'package:evently_app/domain/usecases/login_with_google_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/auth/viewmodel/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<AuthState> {
  LoginUseCase loginUseCase;
  LoginWithGoogleUseCase loginWithGoogleUseCase;
  LoginCubit({required this.loginUseCase,required this.loginWithGoogleUseCase}) : super(AuthInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showPassword=false;

  void login() async {
    if(formKey.currentState!.validate()){
      emit(AuthLoading());

      try {
        var response = await loginUseCase.call(
          email:emailController.text,
          password:passwordController.text,
        );
        await FirebaseAuth.instance.currentUser?.reload();
        var user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          emit(AuthError(
              messageError: '${'email_not_verified'.tr()} ${emailController.text}. ${'verify_logging'.tr()}'));
          return;
        }
        emit(AuthSuccess(user: response));
      } catch (e) {
        emit(AuthError(messageError: e.toString()));
      }
    }
  }

  void togglePassword(){
      showPassword=!showPassword;
      emit(AuthInitial());
  }

  void loginWithGoogle()async{
    emit(AuthLoading());
    try {
      var response = await loginWithGoogleUseCase.call();
      emit(AuthSuccess(user: response));
    } catch (e) {
      emit(AuthError(messageError: e.toString()));
    }
  }
}
