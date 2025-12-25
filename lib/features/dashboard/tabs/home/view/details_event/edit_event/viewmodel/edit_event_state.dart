part of 'edit_event_cubit.dart';

@immutable
sealed class EditEventState {}

final class EditEventInitial extends EditEventState {}
final class EditEventLoading extends EditEventState {}
final class EditEventSuccess extends EditEventState {}
final class EditEventFailure extends EditEventState {
  final String message;
  EditEventFailure({required this.message});
}
final class EditEventValidationSuccess extends EditEventState {}
final class EditEventValidationFailure extends EditEventState {}
final class EditEventCategoryUpdated extends EditEventState {
  final String categoryName;
  EditEventCategoryUpdated(this.categoryName);
}
final class EditEventTimeChanged extends EditEventState {
  final TimeOfDay time;
  EditEventTimeChanged(this.time);
}
final class EditEventDateChanged extends EditEventState {
  final DateTime date;
  EditEventDateChanged(this.date);
}
final class EditEventDataLoaded extends EditEventState {}
final class EditEventLocationChanged extends EditEventState {}
