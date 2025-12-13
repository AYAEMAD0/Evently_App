import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/theme/app_color.dart';
import '../../../../../../../../core/theme/app_style.dart';
import '../../../../../../../../core/widgets/custom_button.dart';
import '../../../../../add_event/widget/choose_event_location.dart';
import '../../../../../add_event/widget/event_category_with_image.dart';
import '../viewmodel/edit_event_cubit.dart';
import 'built_date_edit.dart';
import 'built_form_edit.dart';
import 'built_time_edit.dart';

class BuiltBodyWidgetEdit extends StatelessWidget {
  const BuiltBodyWidgetEdit({super.key,required this.cubit, required this.event});
  final EditEventCubit cubit;
  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EventCategoryWithImage(
          initialCategoryName: cubit.category ??event.category,
          onCategorySelected: (light, dark, name) {
            cubit.updateCategory(light, dark, name);
          },
        ),
        BuiltFormEdit(cubit: cubit,),
        BuiltDateEdit(cubit: cubit,),
        BuiltTimeEdit(cubit: cubit,),
        ChooseEventLocation(
          isAdd: true,
          onPressed: () {
            // TODO: Implement location editing
          },
          value: Text(
            "choose_event_location".tr(),
            style: AppStyle.bold16Primary,
          ),
        ),
        SizedBox(height: 8.h),
        CustomButton(
          onPressed: () {
            cubit.editEvent(context);
          },
          backgroundColor: AppColor.primaryColor,
          paddingHeight: 16.h,
          text: "update_event".tr() ,
          styleText: Theme.of(context).textTheme.displayMedium!,
        )
      ],
    );
  }
}
