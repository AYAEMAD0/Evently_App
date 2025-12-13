import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/features/dashboard/tabs/home/view/details_event/widget/built_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../core/constants/app_asset.dart';
import '../../../../../../../core/routing/routes.dart';
import '../../../../../../../core/theme/app_style.dart';
import '../../../../../../../core/widgets/custom_dialog.dart';
import '../../../../../../../core/widgets/custom_toast.dart';
import '../../../model/event_category_model.dart';
import '../../../viewmodel/get_event_cubit.dart';
import '../viewmodel/delete_event_cubit.dart';

class DetailsEventView extends StatelessWidget {
  const DetailsEventView({super.key, required this.event});
  final EventEntity event;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteEventCubit, DeleteEventState>(
      listener: (context, state) {
        if (state is DeleteEventFailure) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          CustomDialog.showMessage(
            context: context,
            message: state.message,
            title: "Error",
            posActionName: "ok".tr(),
          );
        } else if (state is DeleteEventSuccess) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          context.read<GetEventCubit>().changeIndex(
            0,
            EventCategoryModel.events[0].eventCategory,
          );
          CustomToast.showToast(
            message: "event_deleted".tr(),
            context: context,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.dashBoardRouteName,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("event_details".tr(), style: AppStyle.medium20Primary),
            centerTitle: true,
            actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
            actions: [
              InkWell(
                onTap: () {
                  //todo edit button
                  Navigator.pushNamed(
                    context,
                    Routes.editEventRouteName,
                    arguments: event,
                  );
                },
                child: SvgPicture.asset(AppAsset.editImage),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  //todo delete button
                  CustomDialog.showMessage(
                    context: context,
                    title: "delete_event".tr(),
                    message: "delete_event_confirmation".tr(),
                    posActionName: "ok".tr(),
                    posActionClick: () {
                      //todo delete event
                      context.read<DeleteEventCubit>().deleteEvent(event);
                    },
                    nagActionName: "cancel".tr(),
                  );
                },
                child: SvgPicture.asset(AppAsset.deleteImage),
              ),
            ],
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SingleChildScrollView(child: BuiltBodyWidget(event: event)),
          ),
        );
      },
    );
  }
}
