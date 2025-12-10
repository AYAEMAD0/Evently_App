import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/routing/routes.dart';
import 'package:evently_app/core/widgets/custom_toggle_theme.dart';
import 'package:evently_app/features/onboarding/viewmodel/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_toggle_language.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparentColor,
        title: Image.asset(
          AppAsset.logoImage,
          height:  300.h,
          width: 130.w,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 8.h),
        child: Column(
          spacing: 4.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAsset.onboardingImage1),
            Text(
              "title1".tr(),
              style: AppStyle.bold20PrimaryLight,
              textAlign: TextAlign.start,
            ),
            Text(
              "desc1".tr(),
              style: theme.isDark()
                  ? AppTheme.themeDark.textTheme.headlineSmall
                  : AppTheme.themeLight.textTheme.headlineSmall,
              textAlign: TextAlign.start,
              maxLines: 10,
            ),
            // language
           CustomToggleLanguage(text: 'language'.tr(),),
            SizedBox(height: 3.h),
            // theme
            CustomToggleTheme(),
            Spacer(),
            CustomButton(
                onPressed:  () {
                  //todo nav to onboarding other
                  Navigator.pushReplacementNamed(context, Routes.onBoardingOtherRouteName);
                },
                backgroundColor: AppColor.primaryColor ,
                foregroundColor:AppColor.whiteColor ,
                text: 'let_start'.tr(),
                styleText: AppStyle.medium20White
            ),
          ],
        ),
      ),
    );
  }
}
