import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/validator_helper.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_toggle_language.dart';
import '../widget/already_and_donot_have_account.dart';
import '../widget/built_avatar_register.dart';


class SignupView extends StatelessWidget {
   SignupView({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedAvatarId=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("register".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 15.h),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 20.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuiltAvatarRegister(
                    onAvatarChanged: (index) {
                      selectedAvatarId = index;
                    },),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    hint: "name".tr(),
                    controller: nameController,
                    validator: (text) => ValidatorHelper.validateName(text),
                    hintStyle: Theme.of(context).textTheme.labelLarge!,
                    borderColor: Theme.of(context).colorScheme.outline,
                    fillColor: AppColor.transparentColor,
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Theme.of(
                      context,
                    ).colorScheme.outlineVariant,
                  ),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    keyboard: TextInputType.emailAddress,
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
                  Column(
                    spacing: 20.h,
                        children: [
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
                            obscure:true,
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
                          CustomTextField(
                            textStyle: Theme.of(context).textTheme.labelLarge!,
                            keyboard: TextInputType.visiblePassword,
                            hint: "re_password".tr(),
                            controller: rePasswordController,
                            validator: (text) =>
                                ValidatorHelper.validateConfirmPassword(
                                  text,
                                  passwordController.text,/////todo
                                ),
                            hintStyle: Theme.of(context).textTheme.labelLarge!,
                            borderColor: Theme.of(context).colorScheme.outline,
                            fillColor: AppColor.transparentColor,
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                            obscure: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                //todo show RePassword
                              },
                              icon: Icon(
                               false
                                    ? Icons.visibility_off_sharp
                                    : Icons.visibility,
                              ),
                            ),
                            suffixIconColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                          ),
                        ],
                      ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    onPressed: () async {
                      //todo logic signup
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
