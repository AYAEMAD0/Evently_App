import 'package:evently_app/data/model/event_model_dto.dart';
import 'package:evently_app/domain/entities/event_entity.dart';

extension EventModelDtoMapper on EventModelDto {
  EventEntity toEventEntity() {
    return EventEntity(
      lightImage: lightImage,
      darkImage: darkImage,
      category: category,
      title: title,
      description: description,
      date: date,
      time: time,
    );
  }
}
