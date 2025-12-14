part of 'fav_event_cubit.dart';

@immutable
sealed class FavEventState {}

final class FavEventInitial extends FavEventState {}
final class FavEventLoading extends FavEventState {}
final class FavEventSuccess extends FavEventState {
  final List<EventEntity> eventEntityList;
  FavEventSuccess({required this.eventEntityList});
}
final class FavEventError extends FavEventState {
  final String messageError ;
  FavEventError({required this.messageError});
}

