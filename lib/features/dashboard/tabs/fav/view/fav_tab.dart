import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../viewmodel/fav_event_cubit.dart';
import '../widget/built_body_fav.dart';

class FavTab extends StatefulWidget {
  const FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  late final FavEventCubit viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = context.read<FavEventCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewmodel.getAllFavEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavEventCubit, FavEventState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                CustomTextField(
                  hint: "search_for_event".tr(),
                  controller: viewmodel.searchController,
                  textStyle: Theme.of(context).textTheme.headlineSmall!,
                  hintStyle: AppStyle.bold18PrimaryLight,
                  borderColor: AppColor.primaryColor,
                  prefixIconColor: AppColor.primaryColor,
                  prefixIcon: const Icon(Icons.search),
                  suffixIconColor: AppColor.primaryColor,
                  suffixIcon: IconButton(
                    onPressed: () {
                      //todo clear
                      viewmodel.clearText();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  onChanged: (valueSearch) {
                    viewmodel.onSearchChanged();
                  },
                  fillColor: AppColor.transparentColor,
                ),
                SizedBox(height: 16.h),
                Expanded(child: BuiltBodyFav()),
              ],
            ),
          ),
        );
      },
    );
  }
}
