part of 'delete_event_cubit.dart';

abstract class DeleteEventState {}

class DeleteEventInitial extends DeleteEventState {}

class DeleteEventSuccess extends DeleteEventState {}

class DeleteEventError extends DeleteEventState {
  final String messageError;
  DeleteEventError({required this.messageError});
}
