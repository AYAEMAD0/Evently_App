import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';
import '../entities/event_entity.dart';

@injectable
class AddEventUseCase{
  EventRepo eventRepo;
  AddEventUseCase({required this.eventRepo});

  Future<void>call({required EventEntity event,required String uid}){
    return eventRepo.addEvent(event: event,uid:uid);
  }
}