import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  String? selectedEventId;
  LatLng? userLocationCurrent;

  void selectEvent(String eventId) {
    selectedEventId = eventId;
    emit(MapEventSelected(selectedEventId: eventId));
  }

  void getRequestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      getCurrentLocation();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      emit(MapRequestMapError(errorMessage: "please get location permission"));
    }
  }
  Future<void> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    userLocationCurrent = LatLng(position.latitude, position.longitude);
    emit(MapLocationCurrentLoaded());
  }

}
