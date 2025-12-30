import 'package:evently_app/core/config/di.dart';
import 'package:evently_app/core/routing/routes.dart';
import 'package:evently_app/features/auth/views/forget_password_view.dart';
import 'package:evently_app/features/auth/views/login_view.dart';
import 'package:evently_app/features/auth/views/signup_view.dart';
import 'package:evently_app/features/dashboard/dashboard_view.dart';
import 'package:evently_app/features/dashboard/tabs/add_event/view/add_event_tab.dart';
import 'package:evently_app/features/dashboard/tabs/home/view/details_event/edit_event/view/edit_event_view.dart';
import 'package:evently_app/features/dashboard/tabs/home/view/details_event/edit_event/viewmodel/edit_event_cubit.dart';
import 'package:evently_app/features/dashboard/tabs/home/view/details_event/view/details_event_view.dart';
import 'package:evently_app/features/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/event_entity.dart';
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
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case Routes.addEventRouteName:
        return MaterialPageRoute(builder: (context) => AddEventTab());
      case Routes.detailsEventRouteName:
        final event = settings.arguments as EventEntity?;
        if (event == null) {
          return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text("No Event"))),
          );
        }
        return MaterialPageRoute(
          builder: (context) => DetailsEventView(event: event),
        );
      case Routes.editEventRouteName:
        final event = settings.arguments as EventEntity?;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<EditEventCubit>(),
            child: EditEventView(event: event!),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
