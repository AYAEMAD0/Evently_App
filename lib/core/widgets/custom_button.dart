import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    this.text,
    this.styleText,
    this.isIcon = false,
    this.borderColor,
    this.paddingHeight,
    this.foregroundColor,
    this.iconWidget,
  });
  final void Function() onPressed;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool isIcon;
  final String? text;
  final TextStyle? styleText;
  final double? paddingHeight;
  final Widget? iconWidget;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor:foregroundColor ,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical:paddingHeight?? 13.h,horizontal: 10.w ),
        side:BorderSide(color: borderColor??AppColor.transparentColor,width: 1.5.w) ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
      child: isIcon
          ? iconWidget
          : Text(text!, style: styleText),
    );
  }
}