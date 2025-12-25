import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/config/di.dart';
import 'package:evently_app/core/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../viewmodel/add_event_cubit.dart';
import '../widget/built_form.dart';
import '../widget/choose_event_location.dart';
import '../widget/event_category_with_image.dart';
import 'location_picker_view.dart';

class AddEventTab extends StatelessWidget {
  const AddEventTab({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddEventCubit>(),
      child: BlocConsumer<AddEventCubit, AddEventState>(
        listener: (context, state) {
          if (state is AddEventSuccess) {
            CustomToast.showToast(
              message: "event_added".tr(),
              context: context,
            );
            Navigator.pop(context, true);
          }

          if (state is AddEventError) {
            CustomToast.showToast(message: state.messageError, context: context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AddEventCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text("create_event".tr(), style: AppStyle.medium20Primary),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    spacing: 14.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EventCategoryWithImage(
                        onCategorySelected: (light, dark, name) {
                          cubit.changeCategory(
                            light: light,
                            dark: dark,
                            name: name,
                          );
                        },
                      ),
                      BuiltForm(),
                      ChooseEventLocation(
                        isAdd: true,
                        onPressed: () async{
                          // TODO: add location implementation
                          final cubit = context.read<AddEventCubit>();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: cubit,
                                child: const LocationPickerView(),
                              ),
                            ),
                          );
                          cubit.refreshLocation();
                        },
                        value: Text(
                          cubit.eventAddressLocation ?? "choose_event_location".tr(),
                          style: AppStyle.bold16Primary,
                        ),
                      ),

                      CustomButton(
                        onPressed: () {
                          cubit.addEvent();
                        },
                        backgroundColor: AppColor.primaryColor,
                        paddingHeight: 20.h,
                        text: "add_event".tr(),
                        styleText: Theme.of(context).textTheme.displayMedium!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
