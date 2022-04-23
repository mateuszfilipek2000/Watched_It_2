import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:watched_it_2/api/V3/movies/interfaces/imost_popular_movie_poster.dart';
import 'package:watched_it_2/api/interfaces/iimage_url_provider.dart';
import 'package:watched_it_2/core/config/api_keys.dart';

class TmdbMostPopularMovieImage implements IMostPopularMovieImage {
  const TmdbMostPopularMovieImage();

  /// returns partial url, you need to use image url provider in order to get
  /// full image url
  @override
  Future<String> getMostPopularMovieImageUrl({
    required ImageType imageType,
  }) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$kApiKeyV3&language=en-US&page=1"));

    if (response.statusCode == 200) {
      // succesfully fetched all the most popular movies

      try {
        final List<dynamic> results = json.decode(response.body)["results"];

        //looking for a movie with a non null poster path
        final movieWithImage = results.firstWhere(
          (element) => element["${describeEnum(imageType)}_path"] != null,
        );

        if (movieWithImage["${describeEnum(imageType)}_path"] != null) {
          final imagePath = movieWithImage["${describeEnum(imageType)}_path"];
          return imagePath;
        }
        log("None of the fetched movies has a ${describeEnum(imageType)}");
        log(results.toString());
        throw Exception("Couldn't find movie with ${describeEnum(imageType)}");
      } catch (e) {
        log("Couldn't create movie object from response");
        log("${response.statusCode}: ${response.body}");
        throw Exception("Couldn't create movie object from response");
      }
    }
    log("Request failed, couldn't retrieve most popular movies");
    log("${response.statusCode}: ${response.body}");
    throw Exception("Request failed");
  }
}
