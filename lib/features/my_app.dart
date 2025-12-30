import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../core/config/di.dart';
import '../core/routing/app_router.dart';
import '../core/routing/routes.dart';
import '../core/theme/app_theme.dart';
import 'dashboard/tabs/fav/viewmodel/fav_event_cubit.dart';
import 'dashboard/tabs/home/view/details_event/viewmodel/delete_event_cubit.dart';
import 'dashboard/tabs/home/viewmodel/get_event_cubit.dart';
import 'onboarding/viewmodel/theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.isOnBoarding,
    required this.isLogin,
  });
  final AppRouter appRouter;
  final bool isOnBoarding;
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<GetEventCubit>()..getAllEvents()),
            BlocProvider(create: (_) => getIt<DeleteEventCubit>()),
            BlocProvider(
              create: (_) => getIt<FavEventCubit>()..getAllFavEvents(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: isOnBoarding
                ? Routes.onBoardingRouteName
                : isLogin
                ? Routes.loginRouteName
                : Routes.dashBoardRouteName,
            onGenerateRoute: appRouter.generateRoute,

            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.themeLight,
            darkTheme: AppTheme.themeDark,
            themeMode: theme.themeApp,
          ),
        );
      },
    );
  }
}
