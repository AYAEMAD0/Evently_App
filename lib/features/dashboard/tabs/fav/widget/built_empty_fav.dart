import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_color.dart';

class BuiltEmptyFav extends StatelessWidget {
  const BuiltEmptyFav({super.key, required this.value});
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80.sp,
            color: AppColor.primaryColor.withAlpha(50),
          ),
          SizedBox(height: 16.h),
          Text(
            value ? 'no_favourite_event'.tr() : 'no_search_results'.tr(),
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
