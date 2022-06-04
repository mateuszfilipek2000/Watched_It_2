import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/auth/tmdb_authentication_repository.dart';
import 'package:watched_it_2/api/V3/configuration/implementations/tmdb_api_configuration.dart';
import 'package:watched_it_2/api/V3/configuration/interfaces/iapi_configuration.dart';
import 'package:watched_it_2/api/interfaces/tmdb_image_url.dart';
import 'package:watched_it_2/core/config/approuter.dart';
import 'package:watched_it_2/models/configuration/country_configuration_model.dart';
import 'package:watched_it_2/models/configuration/image_configuration_model.dart';
import 'package:watched_it_2/models/configuration/language_configuration_model.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:watched_it_2/presentation/screens/login_screen/login_screen.dart';

import 'api/interfaces/iimage_url_provider.dart';

void main() async {
  // debugRepaintRainbowEnabled = true;

  // fetching configuration before app starts
  IApiConfiguration apiConfiguration = TmdbApiConfiguration();

  ApiImageConfiguration imageConfiguration =
      await apiConfiguration.getImageConfiguration();

  LanguageConfiguration languageConfiguration =
      await apiConfiguration.getLanguageConfiguration();

  CountryConfiguration countryConfiguration =
      await apiConfiguration.getCountryConfiguration();

  runApp(DevicePreview(builder: (context) {
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider(
        //   create: (context) => TmdbApiConfiguration() as IApiConfiguration,
        //   lazy: false,
        // ),
        RepositoryProvider(
          create: (context) => imageConfiguration,
        ),
        RepositoryProvider(
          create: (context) => languageConfiguration,
        ),
        RepositoryProvider(
          create: (context) => countryConfiguration,
        ),
        RepositoryProvider(
          create: (context) =>
              TmdbImageUrlProvider(imageConfiguration: imageConfiguration)
                  as IImageUrlProvider,
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          TmdbAuthenticationRepository(),
        ),
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
