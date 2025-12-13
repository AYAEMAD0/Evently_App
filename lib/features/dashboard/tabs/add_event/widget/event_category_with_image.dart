import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/features/dashboard/tabs/home/model/event_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../onboarding/viewmodel/theme/theme_provider.dart';
import '../../home/widget/event_category.dart';

class EventCategoryWithImage extends StatefulWidget {
  const EventCategoryWithImage({
    super.key,
    required this.onCategorySelected,
    this.initialCategoryName,
  });

  final Function(
      String imageLightEvent,
      String imageDarkEvent,
      String nameEvent,
      ) onCategorySelected;
  final String? initialCategoryName;

  @override
  State<EventCategoryWithImage> createState() => _EventCategoryWithImageState();
}

class _EventCategoryWithImageState extends State<EventCategoryWithImage> {
  int selectedIndex = 1;
  List<EventCategoryModel> eventsModel = EventCategoryModel.events;
  bool hasNotifySelection = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialCategoryName != null) {
      int foundIndex = eventsModel.indexWhere(
            (event) =>
        event.eventCategory.toLowerCase() ==
            widget.initialCategoryName!.toLowerCase(),
      );
      if (foundIndex != -1 && foundIndex != 0) {
        selectedIndex = foundIndex;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!hasNotifySelection && mounted) {
        notifySelection();
        hasNotifySelection = true;
      }
    });
  }

  void notifySelection() {
    final selectedEvent = eventsModel[selectedIndex];
    widget.onCategorySelected(
      selectedEvent.imageLight!,
      selectedEvent.imageDark!,
      selectedEvent.eventCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

    return Column(
      spacing: 20.h,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            theme.isDark()
                ? eventsModel[selectedIndex].imageDark!
                : eventsModel[selectedIndex].imageLight!,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 55.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: eventsModel.length - 1,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, item) {
              int index = item + 1;
              return InkWell(
                onTap: () {
                  if (selectedIndex != index) {
                    setState(() {
                      selectedIndex = index;
                    });
                    notifySelection();
                  }
                },
                borderRadius: BorderRadius.circular(28.r),
                child: EventCategory(
                  colorBackgroundIsSelected: AppColor.primaryColor,
                  colorIconSelected: Theme.of(context).colorScheme.surface,
                  colorIconNotSelected: AppColor.primaryColor,
                  styleTextSelected: Theme.of(context).textTheme.displayLarge!,
                  styleTextNotSelected: AppStyle.bold16Primary,
                  colorBorderIsSelected: AppColor.primaryColor,
                  selected: index == selectedIndex,
                  eventCategory: eventsModel[index].eventCategory.tr(),
                  icon: eventsModel[index].icon,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}