import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:watched_it_2/api/V3/configuration/implementations/tmdb_country_confiiguration.dart';
import 'package:watched_it_2/api/V3/configuration/implementations/tmdb_image_configuration.dart';
import 'package:watched_it_2/api/V3/configuration/implementations/tmdb_language_configuration.dart';
import 'package:watched_it_2/api/V3/configuration/interfaces/iapi_configuration.dart';
import 'package:watched_it_2/models/configuration/country_configuration_model.dart';
import 'package:watched_it_2/models/configuration/image_configuration_model.dart';
import 'package:watched_it_2/models/configuration/language_configuration_model.dart';

class TmdbApiConfiguration
    with
        TmdbCountryConfiguration,
        TmdbLanguageConfiguration,
        TmdbImageConfiguration
    implements IApiConfiguration {
  TmdbApiConfiguration({
    DateTime? generationDate,
    LanguageConfiguration? languageConfiguration,
    CountryConfiguration? countryConfiguration,
    ImageConfiguration? imageConfiguration,
  })  : _generationDate = generationDate,
        _languageConfiguration = languageConfiguration,
        _countryConfiguration = countryConfiguration,
        _imageConfiguration = imageConfiguration;

  /// retrieves basic api configuration, information about image sizes,
  /// available languages etc.
  /// Sends api request to fetch new configs only if the previous ones are
  /// older than 7 days, or are invalid/empty.
  /// If you want to force getting new configs, then just simply remove
  /// existing ones from shared preferences.
  /// Config is saved in shared prefs under the key of runtimeType.toString()
  Future<void> getApiConfiguration() async {
    // checking if configurations are already saved in shared prefs
    final prefs = await SharedPreferences.getInstance();
    final currentConfig = prefs.getString(runtimeType.toString());

    if (currentConfig != null) {
      try {
        final restoredConfig =
            TmdbApiConfiguration.fromJson(json.decode(currentConfig));

        // checking if configurations are new enough to not retrieve new ones
        if (restoredConfig._generationDate != null &&
            restoredConfig._generationDate!.difference(DateTime.now()).inDays <=
                7) {
          // configs are new enough to be reused, saving as instance variables
          _countryConfiguration = restoredConfig._countryConfiguration;
          _imageConfiguration = restoredConfig._imageConfiguration;
          _generationDate = restoredConfig._generationDate;
          _languageConfiguration = restoredConfig._languageConfiguration;

          return;
        }
      } catch (e) {
        log("Couldn't parse existing results, overwriting");
        log(e.toString());
        // rethrow;
      }
    }

    // configs are too old/do not exist/are corrupted, getting new data

    // getting all the necessary configurations
    _languageConfiguration = await getLanguageConfiguration();
    _countryConfiguration = await getCountryConfiguration();
    _imageConfiguration = await getImageConfiguration();
    _generationDate = DateTime.now();

    // retrieved configurations are now getting saved into shared prefs
    prefs.setString(runtimeType.toString(), json.encode(toJson()));
  }

  @override
  Future<LanguageConfiguration> getLanguageConfiguration() async {
    if (_languageConfiguration != null) {
      return _languageConfiguration!;
    }

    await getApiConfiguration();

    return await getLanguageConfiguration();
  }

  @override
  Future<CountryConfiguration> getCountryConfiguration() async {
    if (_countryConfiguration != null) {
      return _countryConfiguration!;
    }

    await getApiConfiguration();

    return await getCountryConfiguration();
  }

  @override
  Future<ImageConfiguration> getImageConfiguration() async {
    if (_imageConfiguration != null) {
      return _imageConfiguration!;
    }

    await getApiConfiguration();

    return await getImageConfiguration();
  }

  DateTime? _generationDate;
  LanguageConfiguration? _languageConfiguration;
  CountryConfiguration? _countryConfiguration;
  ImageConfiguration? _imageConfiguration;

  factory TmdbApiConfiguration.fromJson(Map<String, dynamic> json) =>
      TmdbApiConfiguration(
        generationDate: DateTime.parse(json["generation_date"]),
        languageConfiguration: LanguageConfiguration.fromJson(
          json["language_configuration"],
        ),
        countryConfiguration: CountryConfiguration.fromJson(
          json["country_configuration"],
        ),
        imageConfiguration: ImageConfiguration.fromJson(
          json["image_configuration"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "generation_date": _generationDate.toString(),
        "language_configuration": _languageConfiguration?.toJson(),
        "country_configuration": _countryConfiguration?.toJson(),
        "image_configuration": _imageConfiguration?.toJson(),
      };
}
