import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/helper/shared_check_helper.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../onboarding/viewmodel/language/language_provider.dart';
import '../../../../onboarding/viewmodel/theme/theme_provider.dart';
import '../viewmodel/profile_cubit.dart';
import 'custom_drop_menu.dart';

class BuiltBodyProfile extends StatelessWidget {
  const BuiltBodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var language = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      child: Column(
        spacing: 14.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'language'.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          //language
          CustomDropMenu(
            initial: language.languageApp,
            onSelected: (value) {
              if (value != null) {
                language.changeLanguage(value as Locale);
                context.setLocale(value);
              }
            },
            menuList: [
              DropdownMenuEntry(
                value: Locale('en'),
                label: 'english'.tr(),
                style: builtStyleBtn(),
              ),
              DropdownMenuEntry(
                value: Locale('ar'),
                label: 'arabic'.tr(),
                style: builtStyleBtn(),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text('theme'.tr(), style: Theme.of(context).textTheme.headlineMedium),
          //theme
          CustomDropMenu(
            key: ValueKey(context.locale),
            initial: theme.themeApp,
            onSelected: (value) {
              if (value != null) {
                theme.changeTheme(value as ThemeMode);
              }
            },
            menuList: [
              DropdownMenuEntry(
                value: ThemeMode.light,
                label: 'light'.tr(),
                style: builtStyleBtn(),
              ),
              DropdownMenuEntry(
                value: ThemeMode.dark,
                label: 'dark'.tr(),
                style: builtStyleBtn(),
              ),
            ],
          ),
          Spacer(),
          CustomButton(
            onPressed: () async {
              //todo logout button
              await context.read<ProfileCubit>().logout();
              await SharedCheckHelper.setValue(
                SharedCheckHelper.keyIsLogin,
                false,
              );
              await Future.delayed(Duration(milliseconds: 300));
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginRouteName,
                  (route) => false,
                );
              }
            },
            backgroundColor: AppColor.redColor,
            isIcon: true,
            iconWidget: Row(
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: AppColor.whiteColor,
                  size: 30,
                ),
                SizedBox(width: 5.h),
                Text('logout'.tr(), style: AppStyle.medium20White),
              ],
            ),
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }

  ButtonStyle builtStyleBtn() {
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColor.blackColor),
    );
  }
}
