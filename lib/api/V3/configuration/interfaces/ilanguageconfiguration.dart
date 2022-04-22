import 'package:watched_it_2/models/configuration/language_configuration_model.dart';

abstract class ILanguageConfiguration {
  Future<LanguageConfiguration> getLanguageConfiguration();
}
