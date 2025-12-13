import 'package:evently_app/domain/entities/event_entity.dart';

abstract class EventRepo{
  Future<void> addEvent({required EventEntity event});
  Future<EventEntity?> getEvent({required String eventCategory});
}