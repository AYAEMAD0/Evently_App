import 'package:evently_app/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/auth/viewmodel/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupCubit extends Cubit<AuthState> {
  SignupUseCase signupUseCase;
  SignupCubit({required this.signupUseCase}) : super(AuthInitial());

  TextEditingController nameController = TextEditingController(text: "aya");
  TextEditingController emailController = TextEditingController(text: "ayaemed8881@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123456");
  TextEditingController rePasswordController = TextEditingController(text: "123456");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedAvatarId = 1;
  bool showPassword=false;
  bool showRePassword=false;

  void signup() async {
    if(formKey.currentState!.validate()){
      emit(AuthLoading());
      try {
        var response = await signupUseCase.call(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
        );
        emit(AuthSuccess(user: response));
      } catch (e) {
        emit(AuthError(messageError: e.toString()));
      }
    }
  }

  void changeIndex(int index){
    selectedAvatarId=index;
    emit(AuthInitial());
  }

  void togglePassword(){
      showPassword=!showPassword;
      emit(AuthInitial());
  }
  void toggleRePassword(){
    showRePassword=!showRePassword;
    emit(AuthInitial());
  }
}
