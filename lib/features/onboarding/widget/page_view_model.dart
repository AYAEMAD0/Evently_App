import 'package:evently_app/features/onboarding/viewmodel/language/language_provider.dart';
import 'package:evently_app/features/onboarding/viewmodel/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/theme/app_theme.dart';

class BuiltPageView {
  final String image;
  final String title;
  final String desc;
  final ThemeProvider theme;
  final LanguageProvider language;

  BuiltPageView({
    required this.image,
    required this.title,
    required this.desc,
    required this.language,
    required this.theme,
  });

  PageViewModel toPageViewModel() {
    return PageViewModel(
      image: Image.asset(image, fit: BoxFit.contain),
      titleWidget: Align(
        alignment: language.isEnglishLanguage()
            ? Alignment.topLeft
            : Alignment.topRight,
        child: Text(title, style: AppStyle.bold20PrimaryLight),
      ),
      bodyWidget: Text(
        desc,
        style: theme.isDark()
            ? AppTheme.themeDark.textTheme.headlineSmall
            : AppTheme.themeLight.textTheme.headlineSmall,
        textAlign: language.languageApp.languageCode == 'en'
            ? TextAlign.left
            : TextAlign.right,
        maxLines: 15,
      ),
    );
  }
}
