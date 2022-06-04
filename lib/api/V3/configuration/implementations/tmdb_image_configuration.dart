import 'dart:convert';
import 'dart:developer';

import 'package:watched_it_2/api/V3/configuration/interfaces/iimageconfiguration.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/configuration/image_configuration_model.dart';
import 'package:http/http.dart' as http;

class TmdbImageConfiguration implements IImageConfiguration {
  @override
  Future<ApiImageConfiguration> getImageConfiguration() async {
    final response = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/configuration?api_key=$kApiKeyV3"),
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      try {
        return ApiImageConfiguration.fromJson(decodedResponse["images"]);
      } catch (e) {
        log("Couldn't parse image configuration");
        log(response.toString());
        log(e.toString());
        rethrow;
      }
    }
    // problem with the request
    log(response.toString());
    log("Couldn't fetch image configuration");
    throw Exception("Problem with image configuration request");
  }
}
