import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/validator_helper.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../viewmodel/forget_password/forget_password_cubit.dart';

class BuiltForgetPassword extends StatelessWidget {
  const BuiltForgetPassword({super.key,required this.viewmodel});
  final ForgetPasswordCubit viewmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          textStyle: Theme.of(context).textTheme.labelLarge!,
          keyboard: TextInputType.emailAddress,
          hint: "email".tr(),
          controller: viewmodel.emailController,
          validator: (text) => ValidatorHelper.validateEmail(text),
          hintStyle: Theme.of(context).textTheme.labelLarge!,
          borderColor: Theme.of(context).colorScheme.outline,
          fillColor: AppColor.transparentColor,
          prefixIcon: Icon(Icons.email),
          prefixIconColor: Theme.of(context).colorScheme.outlineVariant,
        ),
        CustomButton(
          onPressed: () {
            //todo logic reset password
            viewmodel.forgetPassword();
          },
          backgroundColor: AppColor.primaryColor,
          text: 'reset_password'.tr(),
          styleText: AppStyle.medium20White,
        ),
      ],
    );
  }
}
