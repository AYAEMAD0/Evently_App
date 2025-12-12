import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/constants/app_asset.dart';

class EventCategoryModel {
  final String eventName;
  final FontAwesomeIconData icon;
  final String? imageLight;
  final String? imageDark;
  const EventCategoryModel({
    required this.eventName,
    required this.icon,
    this.imageLight,
    this.imageDark,
  });

   static  List<EventCategoryModel> events =const  [
    EventCategoryModel(
      eventName: "all",
      icon: FontAwesome.compass,
    ),
    EventCategoryModel(
      eventName: "sport",
      icon: FontAwesome.basketball_solid,
      imageLight: AppAsset.sportImage,
      imageDark: AppAsset.sportImageDark,
    ),
    EventCategoryModel(
      eventName: "birthday",
      icon: FontAwesome.cake_candles_solid,
      imageLight: AppAsset.birthdayImage,
      imageDark: AppAsset.birthdayImageDark,
    ),
    EventCategoryModel(
      eventName: "meeting",
      icon: FontAwesome.handshake,
      imageLight: AppAsset.meetingImage,
      imageDark: AppAsset.meetingImageDark,
    ),
    EventCategoryModel(
      eventName: "gaming",
      icon: FontAwesome.gamepad_solid,
      imageLight: AppAsset.gamingImage,
      imageDark: AppAsset.gamingImageDark,
    ),
    EventCategoryModel(
      eventName: "workshop",
      icon: FontAwesome.screwdriver_wrench_solid,
      imageLight: AppAsset.workShopImage,
      imageDark: AppAsset.workShopImageDark,
    ),
    EventCategoryModel(
      eventName: "exhibition",
      icon: FontAwesome.image,
      imageLight: AppAsset.exhibitionImage,
      imageDark: AppAsset.exhibitionImageDark,
    ),
    EventCategoryModel(
      eventName: "book_club",
      icon: FontAwesome.book_atlas_solid,
      imageLight: AppAsset.bookClubImage,
      imageDark: AppAsset.bookClubImageDark,
    ),
    EventCategoryModel(
      eventName: "eating",
      icon: FontAwesome.utensils_solid,
      imageLight: AppAsset.eatingImage,
      imageDark: AppAsset.eatingImageDark,
    ),
    EventCategoryModel(
      eventName: "holiday",
      icon: FontAwesome.umbrella_beach_solid,
      imageLight: AppAsset.holidayImage,
      imageDark: AppAsset.holidayImageDark,
    ),
  ];
}
