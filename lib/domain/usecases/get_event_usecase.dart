import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEventUseCase{
  EventRepo eventRepo;
  GetEventUseCase({required this.eventRepo});

  Future<void>call({required String eventCategory}){
    return eventRepo.getEvent(eventCategory: eventCategory);
  }
}