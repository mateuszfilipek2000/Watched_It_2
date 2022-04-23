import 'dart:convert';
import 'dart:developer';

import 'package:watched_it_2/api/V3/movies/interfaces/imovie_details.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/movie/detailed_movie_model.dart';
import 'package:http/http.dart' as http;

typedef DataSource = Future<http.Response> Function();

class TmdbMovieDetails implements IMovieDetails {
  const TmdbMovieDetails({
    this.source,
  });

  @override
  Future<DetailedMovie> getMovieDetails(String id) async {
    final response = await (source != null
        ? source!()
        : http.get(
            Uri.parse(
              "https://api.themoviedb.org/3/movie/$id?api_key=$kApiKeyV3&language=en-US",
            ),
          ));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      try {
        return DetailedMovie.fromJson(decodedResponse);
      } catch (e) {
        log("Couldn't retrieve details of movie with id $id");
        log(e.toString());
        log(response.toString());
        rethrow;
      }
    }
    log("Couldn't retrieve details of movie with id $id");
    log(response.toString());
    throw Exception(response.toString());
  }

  final DataSource? source;
}
