import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_error.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../home/widget/event_item.dart';
import '../viewmodel/fav_event_cubit.dart';
import 'built_empty_fav.dart';

class BuiltBodyFav extends StatelessWidget {
  const BuiltBodyFav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavEventCubit, FavEventState>(
      builder: (context, state) {
        final viewmodel = context.read<FavEventCubit>();
        if (state is FavEventLoading) {
          return const CustomLoading();
        } else if (state is FavEventError) {
          return CustomError(message: state.messageError);
        } else if (state is FavEventSuccess) {
          final filteredList = viewmodel.filteredEvents;
          if (filteredList.isEmpty) {
            return BuiltEmptyFav(
              value: viewmodel.searchController.text.isEmpty,
            );
          }
          return RefreshIndicator(
            color: AppColor.whiteColor,
            onRefresh: () async {
              await viewmodel.getAllFavEvents();
            },
            child: ListView.separated(
              padding: EdgeInsets.only(top: 5.h),
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: filteredList.length,
              itemBuilder: (_, i) => EventItem(
                key: ValueKey(filteredList[i].id),
                model: filteredList[i],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
