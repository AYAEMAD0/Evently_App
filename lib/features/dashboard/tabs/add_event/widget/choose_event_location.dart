import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/widgets/custom_button.dart';

class ChooseEventLocation extends StatelessWidget {
  const ChooseEventLocation({
    super.key,
    required this.value,
    required this.onPressed,
    this.isAdd = false,
  });
  final Widget value;
  final void Function() onPressed;
  final bool isAdd;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: isAdd ? 15.h : 0.h,
      children: [
        isAdd
            ? Row(
                spacing: 5.w,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  Text(
                    "location".tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              )
            : SizedBox.shrink(),

        CustomButton(
          onPressed: onPressed,
          backgroundColor: AppColor.transparentColor,
          borderColor: AppColor.primaryColor,
          isIcon: true,
          iconWidget: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                margin: EdgeInsetsDirectional.only(end: 16.w,bottom: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColor.primaryColor,
                ),
                child: Icon(
                  Icons.my_location_sharp,
                  size: 30,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              value,
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.primaryColor,
              ),
              SizedBox(width: 6.w),
            ],
          ),
        ),
      ],
    );
  }
}
