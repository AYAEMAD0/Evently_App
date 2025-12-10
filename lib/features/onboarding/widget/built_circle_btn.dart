import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_color.dart';

class BuiltCircleBtn extends StatelessWidget {
  const BuiltCircleBtn({super.key, required this.icon, required this.align});
  final IconData icon;
  final AlignmentGeometry align;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        height: 50.h,
        width: 40.w,
        decoration: BoxDecoration(
          border: Border.all(width: 2.w, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Icon(icon, color: AppColor.primaryColor,size: 25.r,),
      ),
    );
  }
}
