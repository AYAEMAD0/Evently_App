import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../features/onboarding/viewmodel/language/language_provider.dart';
import '../../features/onboarding/widget/custom_toggle_switch.dart';
import '../constants/app_asset.dart';


class CustomToggleLanguage extends StatelessWidget {
  const CustomToggleLanguage({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    return CustomToggleSwitch(
      // english 0, arabic 1
      current: language.isEnglishLanguage()?0:1,
      text: text,
      onChanged: (value)  {
        // english 0   arabic 1
        if (value == 0) {
          context.setLocale(const Locale('en'));
          language.changeLanguage(const Locale('en'));
        } else {
          context.setLocale(const Locale('ar'));
          language.changeLanguage(const Locale('ar'));
        }
      },
      customIconBuilder: (context, local, global) {
        if (local.value == 0) {
          return SvgPicture.asset(
            AppAsset.englishImage,
            width: 28.w,
            height: 28.h,
          );
        } else {
          return SvgPicture.asset(
            AppAsset.arabicImage,
            width: 28.w,
            height: 28.h,
          );
        }
      },
    );
  }
}