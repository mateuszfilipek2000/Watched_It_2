import 'package:watched_it_2/models/movie/detailed_movie_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class IMovieDetails {
  Future<DetailedMovie> getMovieDetails(String id);

  // Future<DetailedMovie> getMovieDetails(Map<String, dynamic> json);
}
