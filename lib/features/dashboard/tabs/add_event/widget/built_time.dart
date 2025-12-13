import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../onboarding/viewmodel/language/language_provider.dart';
import '../viewmodel/add_event_cubit.dart';
import 'event_date_and_time.dart';

class BuiltTime extends StatelessWidget {
  const BuiltTime({super.key});

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    var cubit = context.read<AddEventCubit>();

    return  BlocBuilder<AddEventCubit, AddEventState>(
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
    );
  }
}
