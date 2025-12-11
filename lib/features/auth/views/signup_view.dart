import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/config/di.dart';
import 'package:evently_app/features/auth/viewmodel/auth_state.dart';
import 'package:evently_app/features/auth/viewmodel/signup/signup_cubit.dart';
import 'package:evently_app/features/auth/widget/built_signup_bottom.dart';
import 'package:evently_app/features/auth/widget/built_signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_dialog.dart';
import '../widget/built_avatar_register.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    SignupCubit viewmodel = getIt<SignupCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("register".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
      ),
      body: BlocConsumer<SignupCubit, AuthState>(
        bloc: viewmodel,
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthError) {
            CustomDialog.hideLoading(context: context);
            CustomDialog.showMessage(
              context: context,
              title: 'error'.tr(),
              message: state.messageError,
              posActionName: 'ok'.tr(),
            );
          } else if (state is AuthLoading) {
            return CustomDialog.showLoading(context: context);
          } else if (state is AuthSuccess) {
            CustomDialog.hideLoading(context: context);
            CustomDialog.showMessage(
              context: context,
              message:
                  '${'verification_email_sent'.tr()} ${viewmodel.emailController.text} ${"check_inbox".tr()}',
              title: 'successfully'.tr(),
              posActionName: 'ok'.tr(),
              posActionClick: () {
                Navigator.pushReplacementNamed(context, Routes.loginRouteName);
              },
            );
          } else if (state is AuthSuccess) {
            return CustomDialog.showMessage(
              context: context,
              message: 'login_successfully'.tr(),
              title: 'successfully'.tr(),
              posActionName: 'ok'.tr(),
              posActionClick: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.dashBoardRouteName,
                );
              },
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                child: Form(
                  key: viewmodel.formKey,
                  child: Column(
                    spacing: 20.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BuiltAvatarRegister(
                        onAvatarChanged: (index) {
                          viewmodel.changeIndex(index);
                        },
                      ),
                      BuiltSignupForm(viewmodel: viewmodel),
                      BuiltSignupBottom(viewmodel: viewmodel),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
