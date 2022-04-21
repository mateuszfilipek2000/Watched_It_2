import 'package:flutter/material.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:watched_it_2/presentation/screens/login_screen/login_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        //TODO ADD SAVED LOGIN CREDENTIALS CHECK
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case DashboardScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
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
