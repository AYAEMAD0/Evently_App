import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/widgets/custom_error.dart';
import 'package:evently_app/core/widgets/custom_loading.dart';
import 'package:evently_app/features/dashboard/tabs/home/viewmodel/get_event_cubit.dart';
import 'package:evently_app/features/dashboard/tabs/home/widget/built_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/event_category_model.dart';
import '../widget/event_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<EventCategoryModel> eventsCategoryModel =
      EventCategoryModel.events;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEvents();
    });
  }

  void _loadEvents() {
    if (eventsCategoryModel.isEmpty) return;
    final cubit = context.read<GetEventCubit>();
    final category = eventsCategoryModel[cubit.selectedIndex].eventCategory;
    cubit.changeIndex(cubit.selectedIndex, category);
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return CustomLoading();
    }

    return SafeArea(
      child: Column(
        children: [
          BuiltHeader(user: user),
          BlocBuilder<GetEventCubit, GetEventState>(
            builder: (context, state) {
              if (state is GetEventSuccess) {
                final events = state.eventEntityList;
                if (events.isEmpty) {
                  return Expanded(
                    child: CustomError(message: "no_events_yet".tr()),
                  );
                } else {
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 16.h, bottom: 26.h),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: InkWell(
                            onTap: () {
                              //todo nav details
                            },
                            child: EventItem(model: events[index]!),
                          ),
                        );
                      },
                    ),
                  );
                }
              } else if (state is GetEventError) {
                return Expanded(
                  child: CustomError(message: state.messageError),
                );
              }
              return Expanded(child: CustomLoading());
            },
          ),
        ],
      ),
    );
  }
}
