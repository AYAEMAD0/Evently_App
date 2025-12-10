import 'package:evently_app/core/routing/routes.dart';
import 'package:evently_app/features/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/views/onboarding_other_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingRouteName:
        return MaterialPageRoute(builder: (context) => OnboardingView());
      case Routes.onBoardingOtherRouteName:
        return MaterialPageRoute(builder: (context) => OnboardingOtherView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
