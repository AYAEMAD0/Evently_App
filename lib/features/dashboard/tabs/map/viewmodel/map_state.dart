part of 'map_cubit.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapEventSelected extends MapState {
  final String selectedEventId;
  MapEventSelected({required this.selectedEventId});
}
class MapLocationCurrentLoaded extends MapState {}
class MapRequestMapError extends MapState {
  final String errorMessage;
  MapRequestMapError({required this.errorMessage});
}