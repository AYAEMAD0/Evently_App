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
}
