import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_toggle_language.dart';
import '../viewmodel/signup/signup_cubit.dart';
import 'already_and_donot_have_account.dart';

class BuiltSignupBottom extends StatelessWidget {
  const BuiltSignupBottom({super.key,required this.viewmodel});
  final SignupCubit viewmodel;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10.h),
        CustomButton(
          onPressed: () async {
            //todo logic signup
            viewmodel.signup();
          },
          backgroundColor: AppColor.primaryColor,
          text: 'create_account'.tr(),
          styleText: AppStyle.medium20White,
        ),
        AlreadyAndDonotHaveAccount(
          text: 'already_have_account'.tr(),
          textButton: "login".tr(),
          onPressed: () {
            //todo nav into login
            Navigator.pushNamed(context, Routes.loginRouteName);
          },
        ),
        Align(
          alignment: Alignment.center,
          child: CustomToggleLanguage(),
        ),
      ],);
  }
}
