import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../../onboarding/viewmodel/language/language_provider.dart';
import '../../../../../add_event/widget/event_date_and_time.dart';
import '../viewmodel/edit_event_cubit.dart';

class BuiltDateEdit extends StatelessWidget {
  const BuiltDateEdit({super.key, required this.cubit});
  final EditEventCubit cubit;

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    return BlocBuilder<EditEventCubit, EditEventState>(
      buildWhen: (previous, current) =>
          current is EditEventDateChanged ||
          current is EditEventDataLoaded ||
          current is EditEventValidationError,
      builder: (context, state) {
        return EventDateAndTime(
          icon: Icons.calendar_month_outlined,
          colorIcon: Theme.of(context).colorScheme.onTertiary,
          text: "event_date".tr(),
          textButton: cubit.selectedDate == null
              ? 'choose_date'.tr()
              : language.isEnglishLanguage()
              ? '${cubit.selectedDate!.day}/${cubit.selectedDate!.month}/${cubit.selectedDate!.year}'
              : DateFormat.yMd('ar').format(cubit.selectedDate!),
          onPressed: () async => await cubit.chooseDate(context),
        );
      },
    );
  }
}
