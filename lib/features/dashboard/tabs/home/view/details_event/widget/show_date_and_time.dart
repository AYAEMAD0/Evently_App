import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/theme/app_color.dart';
import '../../../../../../../core/theme/app_style.dart';
import '../../../../../../onboarding/viewmodel/language/language_provider.dart';

class ShowDateAndTime extends StatelessWidget {
  const ShowDateAndTime({
    super.key,
    this.isIconEnd = true,
    required this.event,
  });
  final bool isIconEnd;
  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);


    DateTime parsedTime;
    try {
      parsedTime = DateFormat.jm('en').parse(event.time);

    } catch (e) {
      try {
        parsedTime = DateFormat.jm('ar').parse(event.time);
      } catch (e2) {
        parsedTime = DateTime.now();
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.primaryColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            margin: EdgeInsetsDirectional.only(end: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColor.primaryColor,
            ),
            child: Icon(
              Icons.calendar_month_outlined,
              size: 30,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              language.isEnglishLanguage()
                  ? Text(
                DateFormat('d MMM yyyy', 'en').format(event.date),
                style: AppStyle.bold16Primary,
              )
                  : Text(
                DateFormat('d MMM yyyy', 'ar').format(event.date),
                style: AppStyle.bold16Primary,
              ),

              language.isEnglishLanguage()
                  ? Text(
                DateFormat.jm('en').format(parsedTime),
                style: AppStyle.bold16Primary,
              )
                  : Text(
                DateFormat.jm('ar').format(parsedTime),
                style: AppStyle.bold16Primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
