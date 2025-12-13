part of 'delete_event_cubit.dart';

abstract class DeleteEventState {}

class DeleteEventInitial extends DeleteEventState {}

class DeleteEventSuccess extends DeleteEventState {}

class DeleteEventFailure extends DeleteEventState {
  final String message;
  DeleteEventFailure({required this.message});
}
