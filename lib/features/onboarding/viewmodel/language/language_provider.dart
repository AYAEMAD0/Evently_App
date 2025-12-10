import 'package:flutter/material.dart';
import '../../../../core/helper/shared_check_helper.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale languageApp;
  static String languageKey= "Language";

  LanguageProvider(isEnglish){
    languageApp=isEnglish?Locale('en'):Locale('ar');
  }

  void changeLanguage(Locale newLocale)async {
    if (languageApp.languageCode == newLocale.languageCode) {
      return;
    } else {
      languageApp = newLocale;
    }
    SharedCheckHelper.setValue(languageKey,isEnglishLanguage());
    notifyListeners();
  }

  bool isEnglishLanguage() {
    return languageApp.languageCode == 'en';
  }
}
