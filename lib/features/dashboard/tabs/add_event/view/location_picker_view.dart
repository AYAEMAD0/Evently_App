import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/theme/app_style.dart';
import 'package:evently_app/core/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../viewmodel/add_event_cubit.dart';

class LocationPickerView extends StatefulWidget {
  const LocationPickerView({super.key});

  @override
  State<LocationPickerView> createState() => _LocationPickerViewState();
}

class _LocationPickerViewState extends State<LocationPickerView> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AddEventCubit>().getRequestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEventCubit, AddEventState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is EventLocationSelected) {
          CustomToast.showToast(
            message: "location_selected_successfully".tr(),
            context: context,
          );
        }
      },
      builder: (context, state) {
        var viewmodel = context.read<AddEventCubit>();
        if (viewmodel.userLocationCurrent == null) {
          return Scaffold(
            body: const Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            ),
          );
        } else {
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                    target:
                        viewmodel.userLocationCurrent ??
                        LatLng(31.258787, 30.005530),
                    zoom: 15,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  zoomControlsEnabled: false,
                  onTap: (latLng) async {
                    await viewmodel.changeEventLocation(latLng);
                    if (_mapController != null) {
                      _mapController!.animateCamera(
                        CameraUpdate.newLatLng(latLng),
                      );
                    }
                  },
                  markers: viewmodel.eventLocationCurrent != null
                      ? {
                          Marker(
                            markerId: MarkerId("selected location"),
                            position: viewmodel.eventLocationCurrent!,
                            draggable: true,
                            onDragEnd: (latLng) {
                              viewmodel.changeEventLocation(latLng);
                            },
                          ),
                        }
                      : {},
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColor.primaryColor),
                    child: Text(
                      "tap_on_location_to_select".tr(),
                      style: AppStyle.bold16White,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
