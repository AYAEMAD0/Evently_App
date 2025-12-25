import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../../core/theme/app_color.dart';
import '../../../../../../../core/theme/app_style.dart';
import '../../../../../../../domain/entities/event_entity.dart';
import '../../../../add_event/widget/choose_event_location.dart';

class ShowMapDetails extends StatelessWidget {
  const ShowMapDetails({super.key, required this.event});
  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    final LatLng eventLatLng = LatLng(event.latLocation, event.lngLocation);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 23.h,
      children: [
        //location
        ChooseEventLocation(
          onPressed: () {},
          value: Text(event.detailsLocation, style: AppStyle.bold16Primary),
        ),
        //todo map
        Container(
          height: 500.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColor.primaryColor,width: 1.7.w),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: eventLatLng,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("event_location"),
                  position: eventLatLng,
                ),
              },
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              liteModeEnabled: true,
            ),
          ),
        ),
      ],
    );
  }
}
