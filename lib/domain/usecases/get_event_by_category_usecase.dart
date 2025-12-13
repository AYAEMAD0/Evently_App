import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEventByCategoryUseCase{
  EventRepo eventRepo;
  GetEventByCategoryUseCase({required this.eventRepo});

  Future<List<EventEntity?>>call({required String eventCategory}){
    return eventRepo.getEventsByCategory(eventCategory: eventCategory);
  }
}