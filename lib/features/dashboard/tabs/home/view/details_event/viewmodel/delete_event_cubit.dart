import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:evently_app/domain/usecases/delete_event_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'delete_event_state.dart';

@injectable
class DeleteEventCubit extends Cubit<DeleteEventState> {
  final DeleteEventUseCase deleteEventUseCase;

  DeleteEventCubit({required this.deleteEventUseCase})
      : super(DeleteEventInitial());


  Future<void> deleteEvent(EventEntity event) async {
    try {
      await deleteEventUseCase.call(event: event);
      emit(DeleteEventSuccess());
    } catch (e) {
      emit(DeleteEventFailure(message: e.toString()));
    }
  }


}
