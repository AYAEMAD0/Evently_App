import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/helper/validator_helper.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
   ForgetPasswordView({super.key});

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forget_password".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 15.h),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      AppAsset.forgetPasswordImage,
                      height: 320.h,
                    ),
                    SizedBox(height: 8.h),
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
                    CustomButton(
                      onPressed: () {
                        //todo logic reset password
                      },
                      backgroundColor: AppColor.primaryColor,
                      text: 'reset_password'.tr(),
                      styleText: AppStyle.medium20White,
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
