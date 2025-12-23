import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../../../core/theme/app_color.dart';
import '../../../../../../../../core/theme/app_style.dart';
import '../viewmodel/edit_event_cubit.dart';

class LocationPickerViewEdit extends StatefulWidget {
  const LocationPickerViewEdit({super.key});

  @override
  State<LocationPickerViewEdit> createState() => _LocationPickerViewEditState();
}

class _LocationPickerViewEditState extends State<LocationPickerViewEdit> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEventCubit, EditEventState>(
      builder: (context, state) {
        final cubit = context.read<EditEventCubit>();

        if (cubit.eventLocationCurrent == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: cubit.eventLocationCurrent!,
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                zoomControlsEnabled: false,
                onTap: (latLng) async {
                  cubit.changeEventLocation(latLng);
                  _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("event_location"),
                    position: cubit.eventLocationCurrent!,
                    draggable: true,
                    onDragEnd: (latLng) async {
                      cubit.changeEventLocation(latLng);
                    },
                  ),
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  color: AppColor.primaryColor,
                  alignment: Alignment.center,
                  child: Text(
                    "Tap to Change Location".tr(),
                    style: AppStyle.bold16White,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
