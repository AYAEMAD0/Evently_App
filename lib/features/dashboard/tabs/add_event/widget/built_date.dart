import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../onboarding/viewmodel/language/language_provider.dart';
import '../viewmodel/add_event_cubit.dart';
import 'event_date_and_time.dart';

class BuiltDate extends StatelessWidget {
  const BuiltDate({super.key});

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    var cubit = context.read<AddEventCubit>();
    return BlocBuilder<AddEventCubit, AddEventState>(
      buildWhen: (previous, current) =>
          current is AddEventDateChanged || current is AddEventError,
      builder: (context, state) {
        String? validationMessage;
        if (state is AddEventError && cubit.selectedDate == null) {
          validationMessage = "date_required".tr();
        }
        return EventDateAndTime(
          icon: Icons.calendar_month_outlined,
          colorIcon: Theme.of(context).colorScheme.onTertiary,
          text: "event_date".tr(),
          textCheckValue: validationMessage,
          textButton: cubit.selectedDate == null
              ? 'choose_date'.tr()
              : language.isEnglishLanguage()
              ? '${cubit.selectedDate!.day}/${cubit.selectedDate!.month}/${cubit.selectedDate!.year}'
              : DateFormat.yMd('ar').format(cubit.selectedDate!),
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              cubit.setDate(date);
            }
          },
        );
      },
    );
  }
}
