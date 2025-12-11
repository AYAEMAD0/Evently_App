import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/config/di.dart';
import 'package:evently_app/core/widgets/custom_dialog.dart';
import 'package:evently_app/features/auth/viewmodel/auth_state.dart';
import 'package:evently_app/features/auth/viewmodel/login/login_cubit.dart';
import 'package:evently_app/features/auth/widget/built_login_bottom.dart';
import 'package:evently_app/features/auth/widget/built_login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit viewmodel = getIt<LoginCubit>();
    return BlocConsumer<LoginCubit, AuthState>(
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
            message: 'login_successfully'.tr(),
            posActionName: 'ok'.tr(),
            posActionClick: () {
              return Navigator.pushReplacementNamed(
                context,
                Routes.dashBoardRouteName,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                child: Form(
                  key: viewmodel.formKey,
                  child: Column(
                    spacing: 10.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(AppAsset.logoAuthImage, height: 140.h),
                      SizedBox(height: 10.h),
                      BuiltLoginForm(viewmodel: viewmodel),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            //todo forget password
                            Navigator.pushNamed(
                              context,
                              Routes.forgetPasswordRouteName,
                            );
                          },
                          child: Text(
                            "forget".tr(),
                            style: AppStyle.bold16Primary.copyWith(
                              decorationColor: AppColor.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      BuiltLoginBottom(viewmodel: viewmodel),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
