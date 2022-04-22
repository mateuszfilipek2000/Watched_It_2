import 'dart:convert';
import 'dart:developer';

import 'package:watched_it_2/api/V3/configuration/interfaces/ilanguageconfiguration.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:http/http.dart' as http;
import 'package:watched_it_2/models/configuration/language_configuration_model.dart';

class TmdbLanguageConfiguration implements ILanguageConfiguration {
  @override
  Future<LanguageConfiguration> getLanguageConfiguration() async {
    final response = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/configuration/languages?api_key=$kApiKeyV3"),
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      try {
        return LanguageConfiguration.fromJson(decodedResponse);
      } catch (e) {
        log("Couldn't parse langauge configuration");
        log(response.toString());
        log(e.toString());
        rethrow;
      }
    }
    // problem with the request
    log(response.toString());
    log("Couldn't fetch langauge configuration");
    throw Exception("Problem with langauge configuration request");
  }
}
