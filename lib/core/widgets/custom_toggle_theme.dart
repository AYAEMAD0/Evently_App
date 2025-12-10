import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/features/onboarding/viewmodel/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../features/onboarding/widget/custom_toggle_switch.dart';
import '../constants/app_asset.dart';
import '../theme/app_color.dart';


class CustomToggleTheme extends StatelessWidget {
  const CustomToggleTheme({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return  CustomToggleSwitch(
      // 1 dark, 0 light
      current: theme.isDark() ? 1 : 0,
      text: 'theme'.tr(),
      onChanged: (value) {
        // Light 0    Dark 1
        if (value == 0) {
          theme.changeTheme(ThemeMode.light);
        } else {
          theme.changeTheme(ThemeMode.dark);
        }
      },
      customIconBuilder: (context, local, global) {
        if (local.value == 0) {
          return SvgPicture.asset(
            AppAsset.sunLightImage,
            colorFilter: ColorFilter.mode(
                !(theme.isDark())
                ? AppColor.whiteColor
                : AppColor.primaryColor,BlendMode.srcIn),
            height: 22.h,
          );
        } else {
          return SvgPicture.asset(
            AppAsset.moonImage,
            colorFilter: ColorFilter.mode(
                theme.isDark()
                    ? AppColor.whiteColor
                    : AppColor.primaryColor,BlendMode.srcIn),
            height: 24.h,
          );
        }
      },);
  }
}