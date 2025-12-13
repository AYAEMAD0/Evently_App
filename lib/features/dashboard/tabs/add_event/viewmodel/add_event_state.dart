part of 'add_event_cubit.dart';

@immutable
sealed class AddEventState {}

class AddEventInitial extends AddEventState {}

class AddEventLoading extends AddEventState {}

class AddEventSuccess extends AddEventState {}

class AddEventError extends AddEventState {
  final String message;
  AddEventError(this.message);
}

class AddEventDateChanged extends AddEventState {}

class AddEventTimeChanged extends AddEventState {}

class AddEventCategoryChanged extends AddEventState {}
