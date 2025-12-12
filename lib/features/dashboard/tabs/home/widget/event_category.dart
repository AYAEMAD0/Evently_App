import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class EventCategory extends StatelessWidget {
  const EventCategory({
    super.key,
    required this.selected,
    required this.eventName,
    required this.icon,
    required this.colorBorderIsSelected,
    required this.styleTextSelected,
    required this.styleTextNotSelected,
    required this.colorIconSelected,
    required this.colorIconNotSelected,
    required this.colorBackgroundIsSelected,
  });
  final bool selected;
  final Color colorBorderIsSelected;
  final Color colorBackgroundIsSelected;
  final Color colorIconSelected;
  final Color colorIconNotSelected;
  final TextStyle styleTextSelected;
  final TextStyle styleTextNotSelected;
  final String eventName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        color: selected
            ? colorBackgroundIsSelected
            : AppColor.transparentColor,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: colorBorderIsSelected ,width: 1.5.w),
      ),
      child: Row(
        spacing: 8.w,
        children: [
          Icon(icon,color: selected
              ? colorIconSelected
              :colorIconNotSelected
          ),
          Text(
            eventName,
            style: selected
                ? styleTextSelected
                : styleTextNotSelected,
          ),
        ],
      ),
    );
  }
}
