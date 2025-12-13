import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../domain/entities/event_entity.dart';
import '../../../../../domain/usecases/add_event_usecase.dart';
part 'add_event_state.dart';

@injectable
class AddEventCubit extends Cubit<AddEventState> {
  final AddEventUseCase addEventUseCase;

  AddEventCubit(this.addEventUseCase) : super(AddEventInitial());

  int selectedIndex = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String? imageLightEvent;
  String? imageDarkEvent;
  String? categoryName;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void changeCategory({
    required String light,
    required String dark,
    required String name,
  }) {
    if (imageLightEvent != light ||
        imageDarkEvent != dark ||
        categoryName != name) {
      imageLightEvent = light;
      imageDarkEvent = dark;
      categoryName = name;
      emit(AddEventCategoryChanged());
    }
  }

  void setDate(DateTime date) {
    if (selectedDate != date) {
      selectedDate = date;
      emit(AddEventDateChanged());
    }
  }

  void setTime(TimeOfDay time) {
    if (selectedTime != time) {
      selectedTime = time;
      emit(AddEventTimeChanged());
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> addEvent() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedDate == null || selectedTime == null) {
      emit(AddEventError("date_time_required"));
      return;
    }
    if (imageLightEvent == null || imageDarkEvent == null || categoryName == null) {
      emit(AddEventError("category_required"));
      return;
    }

    emit(AddEventLoading());

    try {
      final event = EventEntity(
        lightImage: imageLightEvent!,
        darkImage: imageDarkEvent!,
        category: categoryName!,
        title: titleController.text.trim(),
        description: descController.text.trim(),
        date: selectedDate!,
        time: _formatTime(selectedTime!),
      );

      await addEventUseCase(event: event);
      emit(AddEventSuccess());
    } catch (e) {
      emit(AddEventError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descController.dispose();
    return super.close();
  }
}
