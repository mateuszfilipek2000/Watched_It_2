import 'package:watched_it_2/models/configuration/country_configuration_model.dart';

abstract class ICountryConfiguration {
  Future<CountryConfiguration> getCountryConfiguration();
}
