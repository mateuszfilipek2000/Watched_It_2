import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/auth/tmdb_authentication_repository.dart';
import 'package:watched_it_2/api/V3/configuration/implementations/tmdb_api_configuration.dart';
import 'package:watched_it_2/core/config/approuter.dart';
import 'package:watched_it_2/models/authentication_provider.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:watched_it_2/presentation/screens/login_screen/login_screen.dart';

void main() {
  // debugRepaintRainbowEnabled = true;
  runApp(DevicePreview(builder: (context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TmdbApiConfiguration(),
          lazy: false,
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(TmdbAuthenticationRepository()),
        child: const MyApp(),
      ),
    );
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
      initialRoute: LoginScreen.routeName,
    );
  }
}
