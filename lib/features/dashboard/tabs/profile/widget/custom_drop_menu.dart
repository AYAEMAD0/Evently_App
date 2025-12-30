import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';

class CustomDropMenu extends StatelessWidget {
  const CustomDropMenu({
    super.key,
    required this.initial,
    required this.onSelected,
    required this.menuList,
  });

  final dynamic initial;
  final void Function(Object?) onSelected;
  final List<DropdownMenuEntry<Object>> menuList;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: double.infinity,
      initialSelection: initial,
      textStyle: AppStyle.bold20PrimaryLight,
      trailingIcon: Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
      selectedTrailingIcon: Icon(
        Icons.arrow_drop_up,
        color: AppColor.primaryColor,
      ),
      onSelected: onSelected,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppColor.backgroundLightColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
        fixedSize: WidgetStateProperty.all(Size(365.w, double.nan)),
      ),
      dropdownMenuEntries: menuList,
      inputDecorationTheme: InputDecorationTheme(
        border: builtBorder(),
        enabledBorder: builtBorder(),
        focusedBorder: builtBorder(),
      ),
    );
  }

  OutlineInputBorder builtBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: AppColor.primaryColor, width: 2.5.w),
    );
  }
}
