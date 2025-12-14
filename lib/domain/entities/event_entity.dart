class EventEntity {
  final String? id;
  final String lightImage;
  final String darkImage;
  final String category;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final bool isFavourite;
  //TODO LOCATION

  EventEntity({
    this.id,
    required this.lightImage,
    required this.darkImage,
    required this.category,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isFavourite = false,
  });

  EventEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? lightImage,
    String? darkImage,
    String? time,
    DateTime? date,
    bool? isFavourite,
  }) {
    return EventEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lightImage: lightImage ?? this.lightImage,
      darkImage: darkImage ?? this.darkImage,
      date: date ?? this.date,
      isFavourite: isFavourite ?? this.isFavourite,
      category:  category ?? this.category,
      time:  time ?? this.time,
    );
  }
}
