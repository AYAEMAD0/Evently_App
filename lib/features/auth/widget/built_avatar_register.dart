import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_asset.dart';

class BuiltAvatarRegister extends StatefulWidget {
  final Function(int)? onAvatarChanged;
  const BuiltAvatarRegister({super.key, this.onAvatarChanged});

  @override
  State<BuiltAvatarRegister> createState() => _BuiltAvatarRegisterState();
}

class _BuiltAvatarRegisterState extends State<BuiltAvatarRegister> {
  final List avatarList = const [
    AppAsset.avatar1,
    AppAsset.avatar2,
    AppAsset.avatar3,
    AppAsset.avatar4,
    AppAsset.avatar5,
    AppAsset.avatar6,
    AppAsset.avatar7,
    AppAsset.avatar8,
    AppAsset.avatar9
  ];
  int currentIndex = 0;
  bool isAutoPlay = true;
  CarouselSliderController? carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        enlargeCenterPage: true,
        aspectRatio: 15 / 6,
        viewportFraction: 0.35.h,
        height: 130.h,
        enableInfiniteScroll: false,
        autoPlay: isAutoPlay,
        initialPage: currentIndex,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
          if (widget.onAvatarChanged != null) {
            widget.onAvatarChanged!(index);
          }
        },
      ),
      items: avatarList.map((e) {
        return InkWell(
            onTap: (){
              setState(() {
                isAutoPlay = false;
                currentIndex = avatarList.indexOf(e);
              });
              carouselController!.animateToPage(currentIndex);
              if (widget.onAvatarChanged != null) {
                widget.onAvatarChanged!(currentIndex+1);
              }
            },
            child: Image.asset(e,fit: BoxFit.cover,));
      },).toList()
    );
  }
}
