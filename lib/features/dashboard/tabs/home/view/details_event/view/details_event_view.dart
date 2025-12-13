import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/constants/app_asset.dart';
import '../../../../../../../core/theme/app_color.dart';
import '../../../../../../../core/theme/app_style.dart';
import '../../../../../../../core/widgets/custom_dialog.dart';
import '../../../../../../onboarding/viewmodel/theme/theme_provider.dart';
import '../../../../add_event/widget/choose_event_location.dart';
import '../widget/show_date_and_time.dart';

class DetailsEventView extends StatelessWidget {
  const DetailsEventView({super.key, required this.event});
  final EventEntity event;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("event_details".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
        actions: [
          InkWell(
            onTap: () {
              //todo edit button
              // Navigator.pushNamed(
              //   context,
              //   Routes.editEventRouteName,
              //   arguments: event,
              // );
            },
            child: SvgPicture.asset(AppAsset.editImage),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: () {
              //todo delete button
              CustomDialog.showMessage(
                context: context,
                title: "delete_event".tr() ,
                message:  "delete_event_confirmation".tr(),
                posActionName:  "ok".tr(),
                posActionClick:() {
                  //todo delete event
                },
                nagActionName:  "cancel".tr(),
                nagActionClick: () {
                  //todo cancel
                  Navigator.pop(context);
                },

              );
            },
            child: SvgPicture.asset(AppAsset.deleteImage),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing:16.h,
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
              SizedBox(height: 4.h),
              Text("description".tr(), style: AppStyle.bold20PrimaryLight),
              Text(
                event.description,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
