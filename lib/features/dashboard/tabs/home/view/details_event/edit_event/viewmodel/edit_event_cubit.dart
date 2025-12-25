import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/usecases/edit_event_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng? eventLocationCurrent;
  String? eventAddressLocation;



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
    eventLocationCurrent = LatLng(event.latLocation, event.lngLocation);
    eventAddressLocation = event.detailsLocation;
    emit(EditEventDataLoaded());
  }

  Future<void> chooseDate(BuildContext context) async {
    final initial = (selectedDate != null && selectedDate!.isAfter(DateTime.now()))
        ? selectedDate!
        : DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: Localizations.localeOf(context),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
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
      emit(EditEventTimeChanged(selectedTime!));
    }
  }

  void updateCategory(String lightImage, String darkImage, String categoryName) {
    imageLightEvent = lightImage;
    imageDarkEvent = darkImage;
    category = categoryName;
    emit(EditEventCategoryUpdated(categoryName));
  }


  Future<void> editEvent(BuildContext context) async {
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
        detailsLocation: eventAddressLocation ?? "",
        latLocation: eventLocationCurrent?.latitude ?? 0.0,
        lngLocation: eventLocationCurrent?.longitude ?? 0.0,
      );

      await editEventUseCase.call(event: updatedEvent);
      emit(EditEventSuccess());
    } catch (e) {
      emit(EditEventFailure(message: e.toString()));
    }
  }
  Future<String> getLocationDetails() async {
    if (eventLocationCurrent != null) {
      final placemarks = await placemarkFromCoordinates(
        eventLocationCurrent!.latitude,
        eventLocationCurrent!.longitude,
      );
      eventAddressLocation =
      "${placemarks[0].locality}, ${placemarks[0].country}";
    }
    return eventAddressLocation ?? "";
  }

  void changeEventLocation(LatLng latLng) async {
    eventLocationCurrent = latLng;
    eventAddressLocation = await getLocationDetails();
    emit(EditEventLocationChanged());
  }

}