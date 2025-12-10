import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';

class CustomToggleSwitch extends StatelessWidget {
  const CustomToggleSwitch({
    super.key,
    required this.current,
    this.text,
    required this.onChanged,
    required this.customIconBuilder,
  });
  final int current;
  final String? text;
  final void Function(int) onChanged;
  final Widget Function(
    BuildContext,
    AnimatedToggleProperties<int>,
    DetailedGlobalToggleProperties<int>,
  )
  customIconBuilder;

  @override
  Widget build(BuildContext context) {
    return text == null
        ? AnimatedToggleSwitch<int>.size(
            current: current,
            values: const [0, 1],
            iconOpacity: 1,
            height: 50.h,
            animationDuration: const Duration(seconds: 1),
            animationCurve: Curves.easeInOutBack,
            indicatorSize: Size(38.w, 48.h),
            customIconBuilder: customIconBuilder,
            onChanged: onChanged,
            borderWidth: 3.w,
            style: ToggleStyle(
              borderColor: AppColor.primaryColor,
              indicatorColor: AppColor.primaryColor,
              backgroundColor: AppColor.transparentColor,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text!, style: AppStyle.bold20PrimaryLight),
              AnimatedToggleSwitch<int>.size(
                current: current,
                values: const [0, 1],
                iconOpacity: 1,
                height: 50.h,
                animationDuration: const Duration(seconds: 1),
                animationCurve: Curves.easeInOutBack,
                indicatorSize: Size(38.w, 48.h),
                customIconBuilder: customIconBuilder,
                onChanged: onChanged,
                borderWidth: 3.w,
                style: ToggleStyle(
                  borderColor: AppColor.primaryColor,
                  indicatorColor: AppColor.primaryColor,
                  backgroundColor: AppColor.transparentColor,
                ),
              ),
            ],
          );
  }
}
