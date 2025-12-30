import 'package:evently_app/domain/entities/event_entity.dart';

abstract class EventRepo{
  Future<void> addEvent({required EventEntity event,required String uid});
  Future<List<EventEntity>> getEventsByCategory({required String eventCategory,required String uid});
  Future<List<EventEntity>> getAllEvents({required String uid});
  Future<void> deleteEvent({required EventEntity event,required String uid});
  Future<void> editEvent({required EventEntity event,required String uid});
  Future<List<EventEntity>> getAllFavEvents({required String uid});
  Future<void> changeFavEvent({required String eventId,required bool isFavourite,required String uid}) ;
}