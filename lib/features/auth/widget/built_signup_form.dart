import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/features/auth/viewmodel/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/validator_helper.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/widgets/custom_text_field.dart';

class BuiltSignupForm extends StatelessWidget {
  const BuiltSignupForm({super.key, required this.viewmodel});
  final SignupCubit viewmodel;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          textStyle: Theme.of(context).textTheme.labelLarge!,
          hint: "name".tr(),
          controller: viewmodel.nameController,
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
          controller: viewmodel.emailController,
          validator: (text) =>
              ValidatorHelper.validateEmail(text),
          hintStyle: Theme.of(context).textTheme.labelLarge!,
          borderColor: Theme.of(context).colorScheme.outline,
          fillColor: AppColor.transparentColor,
          prefixIcon: Icon(Icons.email),
          prefixIconColor: Theme.of(
            context,
          ).colorScheme.outlineVariant,
        ),
        CustomTextField(
          textStyle: Theme.of(context).textTheme.labelLarge!,
          keyboard: TextInputType.visiblePassword,
          hint: "password".tr(),
          controller: viewmodel.passwordController,
          validator: (text) =>
              ValidatorHelper.validatePassword(text),
          hintStyle: Theme.of(context).textTheme.labelLarge!,
          borderColor: Theme.of(context).colorScheme.outline,
          fillColor: AppColor.transparentColor,
          prefixIcon: Icon(Icons.lock),
          prefixIconColor: Theme.of(
            context,
          ).colorScheme.outlineVariant,
          obscure: viewmodel.showPassword,
          suffixIcon: IconButton(
            onPressed: () {
              //todo show password
              viewmodel.togglePassword();
            },
            icon: Icon(
              viewmodel.showPassword
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
          controller: viewmodel.rePasswordController,
          validator: (text) =>
              ValidatorHelper.validateConfirmPassword(
                text,
                viewmodel.passwordController.text,
              ),
          hintStyle: Theme.of(context).textTheme.labelLarge!,
          borderColor: Theme.of(context).colorScheme.outline,
          fillColor: AppColor.transparentColor,
          prefixIcon: Icon(Icons.lock),
          prefixIconColor: Theme.of(
            context,
          ).colorScheme.outlineVariant,
          obscure: viewmodel.showRePassword,
          suffixIcon: IconButton(
            onPressed: () {
              //todo show RePassword
              viewmodel.toggleRePassword();
            },
            icon: Icon(
              viewmodel.showRePassword
                  ? Icons.visibility_off_sharp
                  : Icons.visibility,
            ),
          ),
          suffixIconColor: Theme.of(
            context,
          ).colorScheme.outlineVariant,
        ),
    ],);
  }
}
