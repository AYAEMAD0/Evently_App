import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/config/di.dart';
import 'package:evently_app/core/routing/routes.dart';
import 'package:evently_app/features/auth/viewmodel/auth_state.dart';
import 'package:evently_app/features/auth/widget/built_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_dialog.dart';
import '../viewmodel/forget_password/forget_password_cubit.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordCubit viewmodel = getIt<ForgetPasswordCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("forget_password".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
      ),
      body: BlocListener<ForgetPasswordCubit, AuthState>(
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
              title: 'successfully'.tr(),
              message: 'password_reset_sent'.tr(),
              posActionName: 'ok'.tr(),
              posActionClick: () {
                Navigator.pushReplacementNamed(context, Routes.loginRouteName);
              },
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            child: Form(
              key: viewmodel.formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(AppAsset.forgetPasswordImage, height: 320.h),
                    SizedBox(height: 8.h),
                    BuiltForgetPassword(viewmodel: viewmodel),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
