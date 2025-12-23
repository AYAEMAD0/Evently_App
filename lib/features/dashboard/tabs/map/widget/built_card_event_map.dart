import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class BuiltCardEventMap extends StatelessWidget {
  const BuiltCardEventMap({super.key,required this.event});
  final EventEntity event;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 35.h,
        right: 12.w,
        left: 12.w,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 8.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.backgroundLightColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.primaryColor,
          width: 1.7.w,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              event.lightImage,
              width: 135.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            height: 110.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(event.title),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 24,
                    ),
                    const SizedBox(width: 4),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 190.w,
                      ),
                      child: Text(
                        event.detailsLocation,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
