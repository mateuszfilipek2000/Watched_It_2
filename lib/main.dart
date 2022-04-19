import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:watched_it_2/core/config/approuter.dart';

void main() {
  runApp(DevicePreview(builder: (context) {
    return const MyApp();
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watched It 2',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // home: const Text('Flutter Demo Home Page'),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}