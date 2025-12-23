import 'package:evently_app/data/model/event_model_dto.dart';
import 'package:evently_app/domain/entities/event_entity.dart';

extension EventEntityMapper on EventEntity {
  EventModelDto toEventModelDto() {
    return EventModelDto(
      id: id,
      lightImage: lightImage,
      darkImage: darkImage,
      category: category,
      title: title,
      description: description,
      date: date,
      time: time,
      isFavourite: isFavourite,
      detailsLocation: detailsLocation,
      lngLocation: lngLocation,
      latLocation: latLocation,
    );
  }
}
