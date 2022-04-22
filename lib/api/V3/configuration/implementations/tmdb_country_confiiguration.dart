import 'dart:convert';
import 'dart:developer';

import 'package:watched_it_2/api/V3/configuration/interfaces/icountry_configuration.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/configuration/country_configuration_model.dart';
import 'package:http/http.dart' as http;

class TmdbCountryConfiguration implements ICountryConfiguration {
  @override
  Future<CountryConfiguration> getCountryConfiguration() async {
    final response = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/configuration/countries?api_key=$kApiKeyV3"),
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      try {
        return CountryConfiguration.fromJson(decodedResponse);
      } catch (e) {
        log("Couldn't parse country configuration");
        log(response.toString());
        log(e.toString());
        rethrow;
      }
    }
    // problem with the request
    log(response.toString());
    log("Couldn't fetch country configuration");
    throw Exception("Problem with country configuration request");
  }
}
