import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';
import '../entities/event_entity.dart';

@injectable
class EditEventUseCase{
  EventRepo eventRepo;
  EditEventUseCase({required this.eventRepo});

  Future<void>call({required EventEntity event,required String uid}){
    return eventRepo.editEvent(event: event,uid: uid);
  }
}