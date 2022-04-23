import 'package:watched_it_2/api/V3/configuration/interfaces/icountry_configuration.dart';
import 'package:watched_it_2/api/V3/configuration/interfaces/iimageconfiguration.dart';
import 'package:watched_it_2/api/V3/configuration/interfaces/ilanguageconfiguration.dart';

abstract class IApiConfiguration
    implements
        IImageConfiguration,
        ILanguageConfiguration,
        ICountryConfiguration {}
