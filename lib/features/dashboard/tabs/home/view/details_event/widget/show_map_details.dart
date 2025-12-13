import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/theme/app_color.dart';
import '../../../../../../../core/theme/app_style.dart';
import '../../../../add_event/widget/choose_event_location.dart';

class ShowMapDetails extends StatelessWidget {
  const ShowMapDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.h,
      children: [
        //location
        ChooseEventLocation(
          onPressed: () {
            //todo show location
          },
          value: Text(
            "choose_event_location".tr(),
            style: AppStyle.bold16Primary,
          ),
        ),

        //todo map
        Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColor.primaryColor),
          ),
        ),
      ],
    );
  }
}
