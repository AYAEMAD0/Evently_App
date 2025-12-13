part of 'get_event_cubit.dart';

sealed class GetEventState {}

final class GetEventInitial extends GetEventState {}
final class GetEventLoading extends GetEventState {}
final class GetEventSuccess extends GetEventState {
  final List<EventEntity?> eventEntityList;
  GetEventSuccess({required this.eventEntityList});
}
final class GetEventError extends GetEventState {
  final String messageError ;
  GetEventError({required this.messageError});
}