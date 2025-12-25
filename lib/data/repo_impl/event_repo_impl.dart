import 'package:evently_app/data/mappers/event_entity_mapper.dart';
import 'package:evently_app/data/mappers/event_model_dto_mapper.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';
import '../data_sources/remote/event_remote_data_source.dart';

@Injectable(as: EventRepo)
class EventRepoImpl implements EventRepo {
  final EventRemoteDataSource eventRemoteDataSource;
  EventRepoImpl({required this.eventRemoteDataSource});

  @override
  Future<void> addEvent({required EventEntity event,required String uid}) async {
    try{
      //todo EventEntity-->EventModelDto
      final dto = event.toEventModelDto();
      await eventRemoteDataSource.addEvent(dto,uid);
    }catch(e){
      throw Exception('Failed to add event: ${e.toString()}');

    }
  }

  @override
  Future<List<EventEntity>> getAllEvents({required String uid})async{
    try {
      final dtoList = await eventRemoteDataSource.getAllEvents(uid);
      return dtoList.map((e) => e.toEventEntity(),).toList();
    } catch (e) {
      throw Exception('Failed to get all events: ${e.toString()}');
    }
  }

  @override
  Future<List<EventEntity>> getEventsByCategory({required String eventCategory,required String uid})async {
    try {
      final dtoList = await eventRemoteDataSource.getEventsByCategory(eventCategory,uid);
      //todo EventModelDto--->EventEntity
      return dtoList.map((e) => e.toEventEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get events by category $eventCategory: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteEvent({required EventEntity event,required String uid})async {
    try{
      //todo EventEntity-->EventModelDto
      final dto = event.toEventModelDto();
      await eventRemoteDataSource.deleteEvent(dto,uid);
    }catch(e){
      throw Exception('Failed to delete event: ${e.toString()}');

    }
  }

  @override
  Future<void> editEvent({required EventEntity event,required String uid}) async{
    try{
      //todo EventEntity-->EventModelDto
      final dto = event.toEventModelDto();
      await eventRemoteDataSource.editEvent(dto,uid);
    }catch(e){
      throw Exception('Failed to edit event: ${e.toString()}');
    }
  }

  @override
  Future<void> changeFavEvent({required String eventId, required bool isFavourite,required String uid})async {
    try {
      await eventRemoteDataSource.changeFavEvent(eventId, isFavourite,uid);
    } catch (e) {
      throw Exception('Failed to change fav event: ${e.toString()}');
    }
  }

  @override
  Future<List<EventEntity>> getAllFavEvents({required String uid})async {
    try {
      final dtoList = await eventRemoteDataSource.getAllFavEvents(uid);
      //todo EventModelDto--->EventEntity
      return dtoList.map((e) => e.toEventEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get fav event: ${e.toString()}');
    }
  }


}
