import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/features/onboarding/viewmodel/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
class CustomToast{
  static void showToast({required String message,required BuildContext context}){
    final theme = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: theme.isDark()?AppColor.primaryColor:AppColor.backgroundDarkColor,
        textColor:theme.isDark()?AppColor.whiteColor:AppColor.whiteBeigeColor,
        fontSize: 22.0.sp,

    );
  }

}