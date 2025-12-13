import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/constants/app_asset.dart';

class EventCategoryModel {
  final String eventCategory;
  final FontAwesomeIconData icon;
  final String? imageLight;
  final String? imageDark;
  const EventCategoryModel({
    required this.eventCategory,
    required this.icon,
    this.imageLight,
    this.imageDark,
  });

   static  List<EventCategoryModel> events =const  [
    EventCategoryModel(
      eventCategory: "all",
      icon: FontAwesome.compass,
    ),
    EventCategoryModel(
      eventCategory: "sport",
      icon: FontAwesome.basketball_solid,
      imageLight: AppAsset.sportImage,
      imageDark: AppAsset.sportImageDark,
    ),
    EventCategoryModel(
      eventCategory: "birthday",
      icon: FontAwesome.cake_candles_solid,
      imageLight: AppAsset.birthdayImage,
      imageDark: AppAsset.birthdayImageDark,
    ),
    EventCategoryModel(
      eventCategory: "meeting",
      icon: FontAwesome.handshake,
      imageLight: AppAsset.meetingImage,
      imageDark: AppAsset.meetingImageDark,
    ),
    EventCategoryModel(
      eventCategory: "gaming",
      icon: FontAwesome.gamepad_solid,
      imageLight: AppAsset.gamingImage,
      imageDark: AppAsset.gamingImageDark,
    ),
    EventCategoryModel(
      eventCategory: "workshop",
      icon: FontAwesome.screwdriver_wrench_solid,
      imageLight: AppAsset.workShopImage,
      imageDark: AppAsset.workShopImageDark,
    ),
    EventCategoryModel(
      eventCategory: "exhibition",
      icon: FontAwesome.image,
      imageLight: AppAsset.exhibitionImage,
      imageDark: AppAsset.exhibitionImageDark,
    ),
    EventCategoryModel(
      eventCategory: "book_club",
      icon: FontAwesome.book_atlas_solid,
      imageLight: AppAsset.bookClubImage,
      imageDark: AppAsset.bookClubImageDark,
    ),
    EventCategoryModel(
      eventCategory: "eating",
      icon: FontAwesome.utensils_solid,
      imageLight: AppAsset.eatingImage,
      imageDark: AppAsset.eatingImageDark,
    ),
    EventCategoryModel(
      eventCategory: "holiday",
      icon: FontAwesome.umbrella_beach_solid,
      imageLight: AppAsset.holidayImage,
      imageDark: AppAsset.holidayImageDark,
    ),
  ];
}
