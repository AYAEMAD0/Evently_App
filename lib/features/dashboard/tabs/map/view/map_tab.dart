import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../domain/entities/event_entity.dart';
import '../../home/viewmodel/get_event_cubit.dart';
import '../viewmodel/map_cubit.dart';
import '../widget/built_card_event_map.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetEventCubit>().getAllEvents();
      context.read<MapCubit>().getRequestPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, mapState) {
        return BlocBuilder<GetEventCubit, GetEventState>(
          builder: (context, eventState) {
            if (eventState is GetEventLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (eventState is GetEventError) {
              return Center(child: Text(eventState.messageError));
            }

            List<EventEntity?> events = [];
            if (eventState is GetEventSuccess) {
              events = eventState.eventEntityList;
            }

            Set<Circle> eventCircles = events.map((event) {
              final isSelected = event!.id == mapCubit.selectedEventId;
              return Circle(
                circleId: CircleId(event.id ?? event.title),
                center: LatLng(event.latLocation, event.lngLocation),
                radius: 200,
                strokeWidth: 20,
                strokeColor: isSelected
                    ? AppColor.primaryColor.withAlpha(50)
                    : Colors.black.withAlpha(50),
                fillColor: isSelected ? AppColor.primaryColor : Colors.black,
              );
            }).toSet();

            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                    target: mapCubit.userLocationCurrent ??
                        const LatLng(31.258787, 30.005530),
                    zoom: 12,
                  ),
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  circles: eventCircles,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: 160.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index]!;
                        return InkWell(
                          onTap: () {
                            mapCubit.selectEvent(event.id!);
                            _mapController?.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(event.latLocation, event.lngLocation),
                              ),
                            );
                          },
                          child: BuiltCardEventMap(event: event),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

