import 'package:watched_it_2/models/movie/movie_model.dart';

abstract class ILatestMovies {
  Future<Iterable<Movie>> getLatestMovies(int page);
}
