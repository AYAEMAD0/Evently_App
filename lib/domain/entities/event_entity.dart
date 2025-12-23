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
  final String detailsLocation;
  final double latLocation;
  final double lngLocation;

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
    required this.detailsLocation,
    required this.lngLocation,
    required this.latLocation,
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
    String? detailsLocation,
    double? lngLocation,
    double? latLocation,

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
      detailsLocation: detailsLocation??this.detailsLocation,
      latLocation: latLocation??this.latLocation,
      lngLocation: lngLocation??this.lngLocation,
    );
  }
}
