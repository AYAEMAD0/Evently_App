import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../../onboarding/viewmodel/language/language_provider.dart';
import '../../../../../add_event/widget/event_date_and_time.dart';
import '../viewmodel/edit_event_cubit.dart';

class BuiltTimeEdit extends StatelessWidget {
  const BuiltTimeEdit({super.key, required this.cubit});
  final EditEventCubit cubit;

  @override
  Widget build(BuildContext context){
  var language = Provider.of<LanguageProvider>(context);
  return  BlocBuilder<EditEventCubit, EditEventState>(
    buildWhen: (previous, current) =>
    current is EditEventTimeChanged ||
        current is EditEventDataLoaded ||
        current is EditEventValidationFailure,
    builder: (context, state) {
      return EventDateAndTime(
        icon: Icons.access_time_rounded,
        colorIcon: Theme.of(context).colorScheme.onTertiary,
        text: "event_time".tr(),
        textCheckValue: cubit.messageRequiredTime,
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
        onPressed: () => cubit.chooseTime(context),
      );
    },
  );
  }
}
