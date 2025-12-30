import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/helper/shared_check_helper.dart';
import 'package:evently_app/features/onboarding/widget/built_circle_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_color.dart';
import '../model/onboarding_model.dart';
import '../viewmodel/language/language_provider.dart';
import '../viewmodel/theme/theme_provider.dart';
import '../widget/page_view_model.dart';


class OnboardingOtherView extends StatelessWidget {
  const OnboardingOtherView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = OnboardingModel.onboardingList;
    var theme = Provider.of<ThemeProvider>(context);
    var language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAsset.logoImage,
          height:  300.h,
          width: 130.w,
        ),
        centerTitle: true,
        backgroundColor: AppColor.transparentColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 18.h),
        child: IntroductionScreen(
          pages: List.generate(model.length, (index) {
            final page = BuiltPageView(
              title: model[index].title.tr(),
              image: model[index].image,
              desc: model[index].desc.tr(),
              theme: theme,
              language: language,
            );
            return page.toPageViewModel();
          }),
          showBackButton: true,
          back: BuiltCircleBtn(
            icon:Icons.arrow_back,
            align: language.isEnglishLanguage()
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
          ),
          next: BuiltCircleBtn(
            icon:Icons.arrow_forward,
            align:language.isEnglishLanguage()
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
          ),
          done: BuiltCircleBtn(
            icon:Icons.arrow_forward,
            align:language.isEnglishLanguage()
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
          ),
          onDone: () async{
            //todo auth
            SharedCheckHelper.setValue(SharedCheckHelper.keyIsOnBoarding, false);
            Navigator.pushReplacementNamed(context, Routes.loginRouteName);
          },
          showDoneButton: true,
          dotsDecorator: DotsDecorator(
            size:  Size.square(12.r),
            color: theme.isDark()
                ? AppColor.whiteBeigeColor
                : AppColor.blackColor,
            activeSize:  Size(25.w, 12.h),
            activeColor: AppColor.primaryColor,
            spacing:  EdgeInsets.symmetric(horizontal: 4.w),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
        ),
      ),
    );
  }
}
