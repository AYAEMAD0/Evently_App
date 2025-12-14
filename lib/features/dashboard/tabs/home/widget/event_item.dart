import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../onboarding/viewmodel/theme/theme_provider.dart';
import '../../fav/viewmodel/fav_event_cubit.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.model});
  final EventEntity model;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavEventCubit, FavEventState, EventEntity>(
      selector: (state) {
        if (state is FavEventSuccess) {
          return state.eventEntityList.firstWhere(
            (e) => e.id == model.id,
            orElse: () => model,
          );
        }
        return model;
      },
      builder: (context, updatedEvent) {
        var isDark = Provider.of<ThemeProvider>(context).isDark();
        return Container(
          height: 320.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.primaryColor, width: 1.2.w),
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: AssetImage(
                isDark ? updatedEvent.darkImage : updatedEvent.lightImage,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //date
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${updatedEvent.date.day}",
                        textAlign: TextAlign.center,
                        style: AppStyle.bold18PrimaryLight,
                      ),
                      Text(
                        DateFormat('MMM').format(updatedEvent.date),
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
                    horizontal: 10.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColor.primaryColor,
                      width: 1.3.w,
                    ),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          updatedEvent.description,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          CustomToast.showToast(
                            message: "event_update".tr(),
                            context: context,
                          );
                          context.read<FavEventCubit>().changeFav(updatedEvent);
                        },
                        icon: Icon(
                          updatedEvent.isFavourite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: AppColor.primaryColor,
                          size: 28.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
