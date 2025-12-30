import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../../../../core/helper/validator_helper.dart';
import '../../../../../../../../core/theme/app_color.dart';
import '../../../../../../../../core/widgets/custom_text_field.dart';
import '../viewmodel/edit_event_cubit.dart';

class BuiltFormEdit extends StatelessWidget {
  const BuiltFormEdit({super.key,required this.cubit});
  final EditEventCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("title".tr(), style: Theme.of(context).textTheme.headlineSmall),
        CustomTextField(
          textStyle: Theme.of(context).textTheme.labelLarge!,
          hint: "event_title".tr(),
          controller: cubit.titleController,
          validator: (text) => ValidatorHelper.validateTitle(text),
          hintStyle: Theme.of(context).textTheme.labelLarge!,
          borderColor: Theme.of(context).colorScheme.outline,
          fillColor: AppColor.transparentColor,
          prefixIcon: const Icon(FontAwesome.pen_to_square),
          prefixIconColor: Theme.of(context).colorScheme.outlineVariant,
        ),
        SizedBox(height: 8.h),
        Text(
          "description".tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        CustomTextField(
          textStyle: Theme.of(context).textTheme.labelLarge!,
          hint: "event_description".tr(),
          controller: cubit.descController,
          validator: (text) => ValidatorHelper.validateDescription(text),
          hintStyle: Theme.of(context).textTheme.labelLarge!,
          borderColor: Theme.of(context).colorScheme.outline,
          fillColor: AppColor.transparentColor,
          maxLines: 5,
        ),
      ],
    );
  }
}
