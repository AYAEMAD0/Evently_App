import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';

class BuiltOrWayLogin extends StatelessWidget {
  const BuiltOrWayLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColor.primaryColor,
            endIndent: 5.w,
            indent: 10.w,
          ),
        ),
        Text("or".tr(), style: AppStyle.medium16Primary),
        Expanded(
          child: Divider(
            color: AppColor.primaryColor,
            endIndent: 5.w,
            indent: 10.w,
          ),
        ),
      ],
    );
  }
}
