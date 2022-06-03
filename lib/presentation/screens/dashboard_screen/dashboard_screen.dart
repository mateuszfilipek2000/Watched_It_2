import 'package:flutter/material.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/dashboard_desktop.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/dashboard_mobile.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = "DashboardScreen";
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 768) {
            return const DashboardDesktop();
          }
          return const DasboardMobile();
        },
      ),
    );
  }
}
