import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/usecases/forget_password_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/auth/viewmodel/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<AuthState> {
  ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordCubit({required this.forgetPasswordUseCase}) : super(AuthInitial());

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void forgetPassword() async {
    if(formKey.currentState!.validate()){
      emit(AuthLoading());
      try {
        User? user = FirebaseAuth.instance.currentUser;
        await user?.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user != null && !user.emailVerified) {
          emit(AuthError(
              messageError: '${'email_not_verified'.tr()} ${emailController.text}.'));
          return;
        }

        await forgetPasswordUseCase.call(email: emailController.text.trim());
        emit(AuthSuccess(message:'password_reset_sent'.tr()));
        emailController.clear();

      } catch (e) {
        emit(AuthError(messageError: e.toString()));
      }
    }
  }

}
