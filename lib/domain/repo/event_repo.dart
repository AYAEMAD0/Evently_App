import 'package:evently_app/domain/entities/event_entity.dart';

abstract class EventRepo{
  Future<void> addEvent({required EventEntity event});
  Future<List<EventEntity>> getEventsByCategory({required String eventCategory});
  Future<List<EventEntity>> getAllEvents();
  Future<void> deleteEvent({required EventEntity event});

}