import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:watched_it_2/api/V3/movies/interfaces/imost_popular_movie_poster.dart';
import 'package:watched_it_2/api/interfaces/tmdb_image_url.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

class TmdbMostPopularMoviePoster implements IMostPopularMoviePoster {
  const TmdbMostPopularMoviePoster();

  /// returns partial url, you need to use image url provider in order to get
  /// full image url
  @override
  Future<String> getMostPopularMoviePosterUrl() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$kApiKeyV3&language=en-US&page=1"));

    if (response.statusCode == 200) {
      // succesfully fetched all the most popular movies

      try {
        final List<dynamic> results = json.decode(response.body)["results"];

        //looking for a movie with a non null poster path
        final movieWithPoster = Movie.fromJson(
          results.firstWhere(
            (element) => element["poster_path"] != null,
          ),
        );

        if (movieWithPoster.posterPath != null) {
          final posterPath = movieWithPoster.posterPath!;
          return posterPath;
        }
        log("None of the fetched movies has had a poster");
        log(results.toString());
        throw Exception("Couldn't find movie with poster");
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
