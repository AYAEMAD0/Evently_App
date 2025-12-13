import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../onboarding/viewmodel/theme/theme_provider.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.model});
  final EventEntity model;

  @override
  Widget build(BuildContext context) {
    var isDark = Provider.of<ThemeProvider>(context).isDark();
    return Container(
      height: 320.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColor, width: 1.2.w),
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(
            isDark ? model.darkImage : model.lightImage,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 8.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //date
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                children: [
                  Text(
                    "${model.date.day}",
                    textAlign: TextAlign.center,
                    style: AppStyle.bold18PrimaryLight,
                  ),
                  Text(
                    DateFormat('MMM').format(model.date),
                    textAlign: TextAlign.center,
                    style: AppStyle.bold18PrimaryLight,
                  ),
                ],
              ),
            ),
            //desc
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal:10.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.primaryColor, width: 1.3.w),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      model.description,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //todo update fav
                    },
                    icon: Icon(
                      model.isFavourite == true
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
