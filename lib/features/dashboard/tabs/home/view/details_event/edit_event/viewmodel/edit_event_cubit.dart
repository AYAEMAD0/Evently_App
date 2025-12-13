import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/usecases/edit_event_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'edit_event_state.dart';

@injectable
class EditEventCubit extends Cubit<EditEventState> {
  final EditEventUseCase editEventUseCase;

  EditEventCubit({required this.editEventUseCase}) : super(EditEventInitial());

  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? imageLightEvent;
  String? imageDarkEvent;
  String? category;
  late EventEntity event;

  String? messageRequiredDate;
  String? messageRequiredTime;

  @override
  Future<void> close() {
    titleController.dispose();
    descController.dispose();
    return super.close();
  }

  void initializeData(EventEntity event) {
    this.event = event;
    titleController = TextEditingController(text: event.title);
    descController = TextEditingController(text: event.description);
    selectedDate = event.date;
    try {
      DateTime parsedDateTime = DateFormat.jm('en').parse(event.time);
      selectedTime = TimeOfDay.fromDateTime(parsedDateTime);
    } catch (e) {
      try {
        DateTime parsedDateTime = DateFormat.jm('ar').parse(event.time);
        selectedTime = TimeOfDay.fromDateTime(parsedDateTime);
      } catch (e2) {
        selectedTime = TimeOfDay.now();
      }
    }

    imageLightEvent = event.lightImage;
    imageDarkEvent = event.darkImage;
    category = event.category;

    emit(EditEventDataLoaded());
  }

  Future<void> chooseDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      messageRequiredDate = null;
      emit(EditEventDateChanged(selectedDate!));
    }
  }

  Future<void> chooseTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;
      messageRequiredTime = null;
      emit(EditEventTimeChanged(selectedTime!));
    }
  }

  void updateCategory(String lightImage, String darkImage, String categoryName) {
    imageLightEvent = lightImage;
    imageDarkEvent = darkImage;
    category = categoryName;
    emit(EditEventCategoryUpdated(categoryName));
  }

  bool validateForm() {
    messageRequiredDate = selectedDate == null ? "date_required".tr() : null;
    messageRequiredTime = selectedTime == null ? "time_required".tr() : null;

    final isFormValid = formKey.currentState?.validate() ?? false;
    final hasDate = selectedDate != null;
    final hasTime = selectedTime != null;
    final hasImages = imageLightEvent != null && imageDarkEvent != null;
    final hasCategory = category != null;

    if (isFormValid && hasDate && hasTime && hasImages && hasCategory) {
      emit(EditEventValidationSuccess());
      return true;
    } else {
      emit(EditEventValidationFailure());
      return false;
    }
  }

  Future<void> editEvent(BuildContext context) async {
    if (!validateForm()) {
      return;
    }

    emit(EditEventLoading());

    try {
      final updatedEvent = EventEntity(
        id: event.id,
        title: titleController.text,
        description: descController.text,
        date: selectedDate!,
        time: selectedTime!.format(context),
        lightImage: imageLightEvent!,
        darkImage: imageDarkEvent!,
        category: category!,
      );

      await editEventUseCase.call(event: updatedEvent);
      emit(EditEventSuccess());
    } catch (e) {
      emit(EditEventFailure(message: e.toString()));
    }
  }
}