import 'package:evently_app/core/config/di.dart';
import 'package:evently_app/features/dashboard/tabs/profile/widget/built_body_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../onboarding/viewmodel/language/language_provider.dart';
import '../viewmodel/profile_cubit.dart';
import '../widget/image_and_name_and_email.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primaryColor,
              leadingWidth: 0,
              toolbarHeight: 180.h,
              shape: RoundedRectangleBorder(
                borderRadius: language.isEnglishLanguage()
                    ? BorderRadius.only(bottomLeft: Radius.circular(80.r))
                    : BorderRadius.only(bottomRight: Radius.circular(80.r)),
              ),
              title: ImageAndNameAndEmail(),
            ),
            body: BuiltBodyProfile()
          );
        }
      ),
    );
  }
}
