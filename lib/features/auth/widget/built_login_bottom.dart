import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_toggle_language.dart';
import '../viewmodel/login/login_cubit.dart';
import 'already_and_donot_have_account.dart';
import 'built_or_way_login.dart';

class BuiltLoginBottom extends StatelessWidget {
  const BuiltLoginBottom({super.key,required this.viewmodel});
  final LoginCubit viewmodel;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          onPressed: () {
            //todo logic login
            viewmodel.login();
          },
          backgroundColor: AppColor.primaryColor,
          text: 'login'.tr(),
          styleText: AppStyle.medium20White,
        ),
        AlreadyAndDonotHaveAccount(
          text: 'do_not_have_account'.tr(),
          textButton: "create_account".tr(),
          onPressed: () {
            //todo nav into signup
            Navigator.pushNamed(context, Routes.signupRouteName);
          },
        ),
        BuiltOrWayLogin(),
        SizedBox(height: 8.h),
        CustomButton(
          onPressed: () {
            //todo login with google
            viewmodel.loginWithGoogle();
          },
          backgroundColor: AppColor.transparentColor,
          borderColor: AppColor.primaryColor,
          paddingHeight: 18.h,
          isIcon: true,
          iconWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAsset.googleImage),
              SizedBox(width: 6.w),
              Text(
                'login_with_google'.tr(),
                style: AppStyle.medium20Primary,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.center,
          child: CustomToggleLanguage(),
        ),
    ],);
  }
}
