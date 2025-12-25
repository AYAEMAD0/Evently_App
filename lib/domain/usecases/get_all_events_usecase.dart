import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllEventsUseCase{
  EventRepo eventRepo;
  GetAllEventsUseCase({required this.eventRepo});

  Future<List<EventEntity?>>call({required String uid}){
    return eventRepo.getAllEvents(uid: uid);
  }
}