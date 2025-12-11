import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/helper/validator_helper.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_toggle_language.dart';
import '../widget/already_and_donot_have_account.dart';
import '../widget/built_or_way_login.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 15.h),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(AppAsset.logoAuthImage, height:130.h),
                    SizedBox(height:10.h),
                    CustomTextField(
                      textStyle: Theme.of(context).textTheme.labelLarge!,
                      hint: "email".tr(),
                      controller: emailController,
                      validator: (text) => ValidatorHelper.validateEmail(text),
                      hintStyle: Theme.of(context).textTheme.labelLarge!,
                      borderColor: Theme.of(context).colorScheme.outline,
                      fillColor: AppColor.transparentColor,
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Theme.of(
                        context,
                      ).colorScheme.outlineVariant,
                    ),
                    SizedBox(height:7.h),
                    CustomTextField(
                          textStyle: Theme.of(context).textTheme.labelLarge!,
                          keyboard: TextInputType.visiblePassword,
                          hint: "password".tr(),
                          controller: passwordController,
                          validator: (text) =>
                              ValidatorHelper.validatePassword(text),
                          hintStyle: Theme.of(context).textTheme.labelLarge!,
                          borderColor: Theme.of(context).colorScheme.outline,
                          fillColor: AppColor.transparentColor,
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Theme.of(
                            context,
                          ).colorScheme.outlineVariant,
                          obscure:false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              //todo show password

                            },
                            icon: Icon(
                             true
                                  ? Icons.visibility_off_sharp
                                  : Icons.visibility,
                            ),
                          ),
                          suffixIconColor: Theme.of(
                            context,
                          ).colorScheme.outlineVariant,
                        ),
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
                    CustomButton(
                      onPressed: () {
                        //todo logic login

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
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
