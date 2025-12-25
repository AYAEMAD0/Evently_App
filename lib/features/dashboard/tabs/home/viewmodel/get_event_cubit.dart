import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/usecases/get_all_events_usecase.dart';
import 'package:evently_app/domain/usecases/get_event_by_category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/helper/shared_check_helper.dart';

part 'get_event_state.dart';
@injectable
class GetEventCubit extends Cubit<GetEventState> {
  GetEventByCategoryUseCase getEventByCategoryUseCase;
  GetAllEventsUseCase getAllEventsUseCase;
  GetEventCubit({required this.getEventByCategoryUseCase,required this.getAllEventsUseCase}) : super(GetEventInitial());
  int selectedIndex=0;

  void getEventByCategory({required String eventCategory})async{
    try{
      emit(GetEventLoading());
      final uid = SharedCheckHelper.getUserId();
      if (uid == null || uid.isEmpty) {
        emit(GetEventError(messageError: "User not logged in"));
        return;
      }
      var eventList =await getEventByCategoryUseCase.call(eventCategory: eventCategory,uid: uid);
      emit(GetEventSuccess(eventEntityList: eventList));
    }catch(e){
      emit(GetEventError(messageError: e.toString()));
    }
  }

  void getAllEvents()async{
    try{
      emit(GetEventLoading());
      final uid = SharedCheckHelper.getUserId();
      if (uid == null || uid.isEmpty) {
        emit(GetEventError(messageError: "User not logged in"));
        return;
      }
      var eventList =await getAllEventsUseCase.call(uid:uid);
      emit(GetEventSuccess(eventEntityList: eventList));
    }catch(e){
      emit(GetEventError(messageError: e.toString()));
    }
  }
  void changeIndex(int index,String category){
    selectedIndex=index;

    if (category == 'all') {
      getAllEvents();
    } else {
      getEventByCategory(eventCategory: category);
    }
  }
}
