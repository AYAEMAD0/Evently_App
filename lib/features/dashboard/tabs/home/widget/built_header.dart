import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/features/dashboard/tabs/home/widget/built_category_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_asset.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../onboarding/viewmodel/theme/theme_provider.dart';

class BuiltHeader extends StatelessWidget {
  const BuiltHeader({super.key, required this.user});
  final User user;


  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Container(
      height: 240.h,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border(
          bottom: BorderSide(color: AppColor.primaryColor, width: 1.4.w),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        spacing: 15.h,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  Text(
                    'welcome'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    user.displayName.toString(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (theme.themeApp == ThemeMode.light) {
                    theme.changeTheme(ThemeMode.dark);
                  } else {
                    theme.changeTheme(ThemeMode.light);
                  }
                },
                child: SvgPicture.asset(
                  theme.isDark() ? AppAsset.sunLightImage : AppAsset.moonImage,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).cardColor,
                    BlendMode.srcIn,
                  ),
                  height: 37.h,
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 6.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  context.locale.languageCode.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          Row(
            spacing: 5.w,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).cardColor,
              ),
              Text(
                'Cairo , Egypt',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          BuiltCategoryTab(),
        ],
      ),
    );
  }
}
