import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeFavEventUseCase{
  EventRepo eventRepo;
  ChangeFavEventUseCase({required this.eventRepo});

  Future<void>call({required String eventId,required bool isFavourite}){
    return eventRepo.changeFavEvent(eventId: eventId,isFavourite: isFavourite);
  }
}