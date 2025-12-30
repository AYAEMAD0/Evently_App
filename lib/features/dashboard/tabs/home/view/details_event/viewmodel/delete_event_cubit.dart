import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/usecases/delete_event_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/helper/shared_check_helper.dart';
part 'delete_event_state.dart';

@injectable
class DeleteEventCubit extends Cubit<DeleteEventState> {
  final DeleteEventUseCase deleteEventUseCase;

  DeleteEventCubit({required this.deleteEventUseCase})
      : super(DeleteEventInitial());


  Future<void> deleteEvent(EventEntity event) async {
    try {
      final uid = SharedCheckHelper.getUserId();
      if (uid == null || uid.isEmpty) {
        emit(DeleteEventError(messageError: "User not logged in"));
        return;
      }
      await deleteEventUseCase.call(event: event,uid: uid);
      emit(DeleteEventSuccess());
    } catch (e) {
      emit(DeleteEventError(messageError: e.toString()));
    }
  }


}
