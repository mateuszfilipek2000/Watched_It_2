import 'package:flutter/material.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:watched_it_2/presentation/screens/logged_in_screen/logged_in_screen.dart';
import 'package:watched_it_2/presentation/screens/login_screen/login_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case DashboardScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: settings,
        );
      case LoggedInScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoggedInScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
    }
  }
}
