import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/theme/app_style.dart';
import '../../../../../../../domain/entities/event_entity.dart';
import '../../../../../../onboarding/viewmodel/theme/theme_provider.dart';
import 'show_date_and_time.dart';
import 'show_map_details.dart';

class BuiltBodyWidget extends StatelessWidget {
  const BuiltBodyWidget({super.key,required this.event});
  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.h,
      children: [
        //image
        ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: Image.asset(
            theme.isDark() ? event.darkImage : event.lightImage,
          ),
        ),
        Text(event.title, style: AppStyle.bold20PrimaryLight),
        SizedBox(height: 4.h),
        //date,time
        ShowDateAndTime(event: event),
        //map
        ShowMapDetails(),
        SizedBox(height: 4.h),
        Text(
            "description".tr(), style: AppStyle.bold20PrimaryLight),
        Text(
          event.description,
          style: Theme
              .of(context)
              .textTheme
              .labelMedium,
        ),
      ],
    );
  }
}
