import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/routing/app_router.dart';
import 'package:evently_app/features/onboarding/viewmodel/language/language_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'core/config/di.dart';
import 'core/config/my_bloc_observer.dart';
import 'core/helper/shared_check_helper.dart';
import 'features/my_app.dart';
import 'features/onboarding/viewmodel/theme/theme_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: FirebaseOptionsHelper.options);

  tz.initializeTimeZones();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);



  configureDependencies();
  Bloc.observer = MyBlocObserver();
  await EasyLocalization.ensureInitialized();
  await SharedCheckHelper.init();
  final bool themeDark =
      await SharedCheckHelper.getValue(ThemeProvider.themeKey) ?? true;
  final bool languageEnglish =
      await SharedCheckHelper.getValue(LanguageProvider.languageKey) ?? true;
  final bool onBoarding =
      await SharedCheckHelper.getValue(SharedCheckHelper.keyIsOnBoarding) ??
      true;
  final bool login =
      await SharedCheckHelper.getValue(SharedCheckHelper.keyIsLogin) ?? true;

  final Locale startedLocale = languageEnglish
      ? const Locale('en')
      : const Locale('ar');

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: startedLocale,
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider(themeDark)),
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(languageEnglish),
          ),
        ],
        child: MyApp(
          appRouter: AppRouter(),
          isOnBoarding: onBoarding,
          isLogin: login,
        ),
      ),
    ),
  );
}
