import 'package:evently_app/core/routing/routes.dart';
import 'package:evently_app/features/auth/views/forget_password_view.dart';
import 'package:evently_app/features/auth/views/login_view.dart';
import 'package:evently_app/features/auth/views/signup_view.dart';
import 'package:evently_app/features/dashboard/dashboard_view.dart';
import 'package:evently_app/features/dashboard/tabs/add_event/view/add_event_tab.dart';
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
      case Routes.loginRouteName:
        return MaterialPageRoute(builder: (context) => LoginView());
      case Routes.signupRouteName:
        return MaterialPageRoute(builder: (context) => SignupView());
      case Routes.forgetPasswordRouteName:
        return MaterialPageRoute(builder: (context) => ForgetPasswordView());
      case Routes.dashBoardRouteName:
        return MaterialPageRoute(builder: (context) => DashboardView());
      case Routes.addEventRouteName:
        return MaterialPageRoute(builder: (context) => AddEventTab());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
