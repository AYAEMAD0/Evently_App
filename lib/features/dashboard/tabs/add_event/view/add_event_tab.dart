import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/config/di.dart';
import 'package:evently_app/core/widgets/custom_toast.dart';
import 'package:evently_app/features/dashboard/tabs/add_event/viewmodel/add_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/helper/validator_helper.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../onboarding/viewmodel/language/language_provider.dart';
import '../widget/choose_event_location.dart';
import '../widget/event_category_with_image.dart';
import '../widget/event_date_and_time.dart';

class AddEventTab extends StatelessWidget {
  const AddEventTab({super.key});
  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    return BlocProvider(
      create: (context) => getIt<AddEventCubit>(),
      child: BlocConsumer<AddEventCubit, AddEventState>(
        listener: (context, state) {
          if (state is AddEventSuccess) {
            CustomToast.showToast(
              message: "event_added".tr(),
              context: context,
            );
            Navigator.pop(context);
          }

          if (state is AddEventError) {
            CustomToast.showToast(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AddEventCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text("create_event".tr(), style: AppStyle.medium20Primary),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    spacing: 14.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EventCategoryWithImage(
                        onCategorySelected: (light, dark, name) {
                          cubit.changeCategory(
                            light: light,
                            dark: dark,
                            name: name,
                          );
                        },
                      ),

                      // Title
                      Text(
                        "title".tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      CustomTextField(
                        textStyle: Theme.of(context).textTheme.labelLarge!,
                        hint: "event_title".tr(),
                        controller: cubit.titleController,
                        validator: (text) =>
                            ValidatorHelper.validateTitle(text),
                        hintStyle: Theme.of(context).textTheme.labelLarge!,
                        borderColor: Theme.of(context).colorScheme.outline,
                        fillColor: AppColor.transparentColor,
                        prefixIcon: const Icon(FontAwesome.pen_to_square),
                        prefixIconColor: Theme.of(
                          context,
                        ).colorScheme.outlineVariant,
                      ),

                      SizedBox(height: 6.h),

                      // Description
                      Text(
                        "description".tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      CustomTextField(
                        textStyle: Theme.of(context).textTheme.labelLarge!,
                        hint: "event_description".tr(),
                        controller: cubit.descController,
                        validator: (text) =>
                            ValidatorHelper.validateDescription(text),
                        hintStyle: Theme.of(context).textTheme.labelLarge!,
                        borderColor: Theme.of(context).colorScheme.outline,
                        fillColor: AppColor.transparentColor,
                        maxLines: 5,
                      ),

                      // Date - Rebuild only when date changes
                      BlocBuilder<AddEventCubit, AddEventState>(
                        buildWhen: (previous, current) =>
                            current is AddEventDateChanged ||
                            current is AddEventError,
                        builder: (context, state) {
                          String? validationMessage;
                          if (state is AddEventError &&
                              cubit.selectedDate == null) {
                            validationMessage = "date_required".tr();
                          }

                          return EventDateAndTime(
                            icon: Icons.calendar_month_outlined,
                            colorIcon: Theme.of(
                              context,
                            ).colorScheme.onTertiary,
                            text: "event_date".tr(),
                            textCheckValue: validationMessage,
                            textButton: cubit.selectedDate == null
                                ? 'choose_date'.tr()
                                : language.isEnglishLanguage()
                                ? '${cubit.selectedDate!.day}/${cubit.selectedDate!.month}/${cubit.selectedDate!.year}'
                                : DateFormat.yMd(
                                    'ar',
                                  ).format(cubit.selectedDate!),
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );
                              if (date != null) {
                                cubit.setDate(date);
                              }
                            },
                          );
                        },
                      ),

                      // Time - Rebuild only when time changes
                      BlocBuilder<AddEventCubit, AddEventState>(
                        buildWhen: (previous, current) =>
                            current is AddEventTimeChanged ||
                            current is AddEventError,
                        builder: (context, state) {
                          String? validationMessage;
                          if (state is AddEventError &&
                              cubit.selectedTime == null) {
                            validationMessage = "time_required".tr();
                          }

                          return EventDateAndTime(
                            icon: Icons.access_time_rounded,
                            colorIcon: Theme.of(
                              context,
                            ).colorScheme.onTertiary,
                            text: "event_time".tr(),
                            textCheckValue: validationMessage,
                            textButton: cubit.selectedTime == null
                                ? 'choose_time'.tr()
                                : language.isEnglishLanguage()
                                ? cubit.selectedTime!.format(context)
                                : DateFormat.jm('ar').format(
                                    DateTime(
                                      0,
                                      1,
                                      1,
                                      cubit.selectedTime!.hour,
                                      cubit.selectedTime!.minute,
                                    ),
                                  ),
                            onPressed: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                cubit.setTime(time);
                              }
                            },
                          );
                        },
                      ),

                      ChooseEventLocation(
                        isAdd: true,
                        onPressed: () {
                          // TODO: add location implementation
                        },
                        value: Text(
                          "choose_event_location".tr(),
                          style: AppStyle.bold16Primary,
                        ),
                      ),

                      // Add Event Button
                      CustomButton(
                        onPressed: state is AddEventLoading
                            ? () {} // Disable button during loading
                            : cubit.addEvent,
                        backgroundColor: AppColor.primaryColor,
                        paddingHeight: 20.h,
                        text: "add_event".tr(),
                        styleText: Theme.of(
                          context,
                        ).textTheme.displayMedium!,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
