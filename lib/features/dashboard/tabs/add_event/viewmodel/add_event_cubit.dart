import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
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
    if (selectedTime == null) {
      emit(AddEventError("time_required".tr()));
      return;
    }
    if (selectedDate == null) {
      emit(AddEventError("date_required".tr()));
      return;
    }
    if (imageLightEvent == null ||
        imageDarkEvent == null ||
        categoryName == null) {
      emit(AddEventError("category_required".tr()));
      return;
    }
    if (eventLocationCurrent == null || eventAddressLocation == null) {
      emit(AddEventError("location_required".tr()));
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
        detailsLocation: eventAddressLocation!,
        latLocation: eventLocationCurrent!.latitude,
        lngLocation: eventLocationCurrent!.longitude
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

  LatLng? userLocationCurrent;
  LatLng? eventLocationCurrent;
  String? eventAddressLocation;

  Future<void> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    userLocationCurrent = LatLng(position.latitude, position.longitude);
    emit(AddEventLocationLoaded());
  }

  void getRequestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      getCurrentLocation();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      emit(AddEventRequestMapError("please_get_location_permission".tr()));
    }
  }

  Future<void> changeEventLocation(LatLng latLang) async {
    eventLocationCurrent = latLang;
    eventAddressLocation = await getLocationDetails();
    emit(EventLocationSelected(latLang));
  }

  Future<String> getLocationDetails() async {
    if (eventLocationCurrent != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        eventLocationCurrent!.latitude,
        eventLocationCurrent!.longitude,
      );
      eventAddressLocation =
      "${placemarks[0].locality ?? ''}, ${placemarks[0].country ?? ''}";
    } else {
      eventAddressLocation = "Unknown location";
    }
    return eventAddressLocation??"";
  }

  void refreshLocation() {
    emit(AddEventLocationChanged());
  }

}
