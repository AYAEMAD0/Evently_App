import 'package:cloud_firestore/cloud_firestore.dart';

class EventModelDto {
  String? id;
  String lightImage;
  String darkImage;
  String category;
  String title;
  String description;
  DateTime date;
  String time;
  bool isFavourite;
  String detailsLocation;
  double latLocation;
  double lngLocation;


  EventModelDto({
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
    required this.latLocation,
    required this.lngLocation,
  });

  EventModelDto.fromFirestore(Map<String, dynamic> json)
      : this(
    id: json["id"],
    lightImage: json["lightImage"] ?? "",
    darkImage: json["darkImage"] ?? "",
    category: json["category"] ?? "",
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    date: (json["date"] as Timestamp).toDate(),
    time: json["time"] ?? "",
    isFavourite: json["isFavourite"] ?? false,
    detailsLocation: json["detailsLocation"]??"",
    latLocation:  json["latLocation"]??0.0,
    lngLocation:  json["lngLocation"]??0.0,
  );

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "lightImage": lightImage,
      "darkImage": darkImage,
      "category": category,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "isFavourite": isFavourite,
      "detailsLocation":detailsLocation,
      "latLocation":latLocation,
      "lngLocation":lngLocation
    };
  }

  static const String collectionName = "Event";
}
