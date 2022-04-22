import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = "DashboardScreen";
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("dashboard"),
        ),
      ),
    );
  }
}
