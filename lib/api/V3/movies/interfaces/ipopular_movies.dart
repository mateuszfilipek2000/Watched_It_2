import 'package:watched_it_2/models/movie/movie_model.dart';

abstract class IPopularMovies {
  Future<Iterable<Movie>> getPopularMovies(int page);
}
