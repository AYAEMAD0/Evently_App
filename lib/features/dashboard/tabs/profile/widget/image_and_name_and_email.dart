import 'package:evently_app/core/widgets/custom_error.dart';
import 'package:evently_app/features/dashboard/tabs/profile/viewmodel/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_asset.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../../core/widgets/custom_loading.dart';

class ImageAndNameAndEmail extends StatelessWidget {
  const ImageAndNameAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileError) {
          return CustomError(message: state.message);
        } else if (state is ProfileSuccess) {
          final user = state.user;
          return Row(
            children: [
              (user.avatarId != null && user.avatarId!.startsWith('http'))
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(80.r),
                      child: Image.network(
                        user.avatarId!,
                        height: 120.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      AppAsset.avatars[int.tryParse(user.avatarId ?? '0') ?? 0],
                      height: 130.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: AppStyle.bold24WhiteLight),
                    Text(
                      user.email,
                      style: AppStyle.medium16White,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const CustomLoading();
        }
      },
    );
  }
}
