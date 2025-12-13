import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';
import '../entities/event_entity.dart';

@injectable
class DeleteEventUseCase{
  EventRepo eventRepo;
  DeleteEventUseCase({required this.eventRepo});

  Future<void>call({required EventEntity event}){
    return eventRepo.deleteEvent(event: event);
  }
}