import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/models/movie/movie_model.dart';

@immutable
abstract class IDiscoverMovies {
  /// returns results as
  /// int page: List<Movie>
  Future<List<Movie>> getDiscoverMovies(int page);
}
