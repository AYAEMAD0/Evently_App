import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../core/routing/routes.dart';
import '../../../../../../../../core/theme/app_style.dart';
import '../../../../../../../../core/widgets/custom_dialog.dart';
import '../../../../../../../../core/widgets/custom_toast.dart';
import '../viewmodel/edit_event_cubit.dart';
import '../widget/built_body_widget_edit.dart';


class EditEventView extends StatefulWidget {
  const EditEventView({super.key, required this.event});
  final EventEntity event;

  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditEventCubit>().initializeData(widget.event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditEventCubit, EditEventState>(
      listener: (context, state) {
        if (state is EditEventSuccess) {
          CustomToast.showToast(message: "event_edited".tr(), context: context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.dashBoardRouteName,
            (route) => false,
          );
        } else if (state is EditEventError) {
          CustomDialog.showMessage(
            context: context,
            message: state.messageError,
            title: "Error".tr(),
            posActionName: "ok".tr(),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditEventCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text("edit_event".tr(), style: AppStyle.medium20Primary),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child:BuiltBodyWidgetEdit(cubit: cubit,event:widget.event)
              ),
            ),
          ),
        );
      },
    );

}}
