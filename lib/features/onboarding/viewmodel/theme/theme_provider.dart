import 'package:flutter/material.dart';
import '../../../../core/helper/shared_check_helper.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeApp;

  static String themeKey="Theme";

  ThemeProvider(bool isDark) {
    themeApp = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (themeApp == newTheme) {
      return;
    } else {
      themeApp = newTheme;
    }
    SharedCheckHelper.setValue(themeKey,isDark());
    notifyListeners();
  }

  bool isDark() {
    return themeApp == ThemeMode.dark;
  }
}