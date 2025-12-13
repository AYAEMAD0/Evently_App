import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../model/event_category_model.dart';
import '../viewmodel/get_event_cubit.dart';
import 'event_category.dart';

class BuiltCategoryTab extends StatelessWidget {
  BuiltCategoryTab({super.key});
  final List<EventCategoryModel> eventsCategoryModel =
      EventCategoryModel.events;
  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<GetEventCubit>();
    return DefaultTabController(
      length: eventsCategoryModel.length,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
        indicatorColor: AppColor.transparentColor,
        dividerColor: AppColor.transparentColor,
        onTap: (value) {
          //todo change tab
          final category = eventsCategoryModel[value].eventCategory;
          viewmodel.changeIndex(value, category);
        },
        tabs: List.generate(
          eventsCategoryModel.length,
          (index) => EventCategory(
            colorBorderIsSelected: Theme.of(context).colorScheme.secondary,
            colorIconSelected: Theme.of(context).colorScheme.primary,
            colorIconNotSelected: Theme.of(context).cardColor,
            styleTextSelected: Theme.of(context).textTheme.labelSmall!,
            styleTextNotSelected: Theme.of(context).textTheme.bodyLarge!,
            colorBackgroundIsSelected: Theme.of(context).colorScheme.secondary,
            selected: index == viewmodel.selectedIndex,
            eventCategory: eventsCategoryModel[index].eventCategory.tr(),
            icon: eventsCategoryModel[index].icon,
          ),
        ),
      ),
    );
  }
}
