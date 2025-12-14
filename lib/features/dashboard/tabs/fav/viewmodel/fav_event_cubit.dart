import 'package:evently_app/domain/usecases/change_fav_event_usecase.dart';
import 'package:evently_app/domain/usecases/get_all_fav_events_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../domain/entities/event_entity.dart';

part 'fav_event_state.dart';

@injectable
class FavEventCubit extends Cubit<FavEventState> {
  GetAllFavEventsUseCase getAllFavEventsUseCase;
  ChangeFavEventUseCase changeFavEventUseCase;

  FavEventCubit({
    required this.getAllFavEventsUseCase,
    required this.changeFavEventUseCase,
  }) : super(FavEventInitial()) {
    getAllFavEvents();
  }

  final searchController = TextEditingController();

  List<EventEntity> filteredEvents = [];

  Future<void> getAllFavEvents() async {
    emit(FavEventLoading());
    try {
      var eventList = await getAllFavEventsUseCase.call();
      filteredEvents = eventList.where((e) => e.isFavourite).toList();
      emit(FavEventSuccess(eventEntityList: eventList));
    } catch (e) {
      emit(FavEventError(messageError: e.toString()));
    }
  }

  void changeFav(EventEntity event) {
    try {
      final currentState = state;
      if (currentState is! FavEventSuccess) return;
      List<EventEntity> currentEvents = currentState.eventEntityList;
      final updatedEvents = currentEvents.map((e) {
        if (e.id == event.id) {
          return e.copyWith(isFavourite: !e.isFavourite);
        }
        return e;
      }).toList();
      if (!event.isFavourite) {
        filteredEvents.add(event.copyWith(isFavourite: true));
      } else {
        filteredEvents.removeWhere((e) => e.id == event.id);
      }
      emit(FavEventSuccess(eventEntityList: updatedEvents));
      changeFavEventUseCase
          .call(eventId: event.id!, isFavourite: !event.isFavourite)
          .catchError((e) {
            emit(FavEventSuccess(eventEntityList: currentEvents));
            filteredEvents = currentEvents.where((e) => e.isFavourite).toList();
          });
    } catch (e) {
      emit(FavEventError(messageError: e.toString()));
    }
  }

  void onSearchChanged() {
    final state = this.state;
    if (state is! FavEventSuccess) return;

    final searchText = searchController.text.toLowerCase();

    if (searchText.isEmpty) {
      filteredEvents = state.eventEntityList
          .where((e) => e.isFavourite)
          .toList();
    } else {
      filteredEvents = state.eventEntityList.where((event) {
        return event.isFavourite &&
            (event.description.toLowerCase().contains(searchText) ||
                event.title.toLowerCase().contains(searchText));
      }).toList();
    }
    emit(FavEventSuccess(eventEntityList: state.eventEntityList));
  }

  void clearText() {
    searchController.clear();
    onSearchChanged();
  }
}
