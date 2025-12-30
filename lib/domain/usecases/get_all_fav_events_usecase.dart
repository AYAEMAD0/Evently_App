import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllFavEventsUseCase{
  EventRepo eventRepo;
  GetAllFavEventsUseCase({required this.eventRepo});

  Future<List<EventEntity>>call({required String uid}){
    return eventRepo.getAllFavEvents(uid: uid);
  }
}