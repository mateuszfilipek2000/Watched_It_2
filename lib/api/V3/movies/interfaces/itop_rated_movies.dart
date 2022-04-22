import 'package:watched_it_2/models/movie/movie_model.dart';

abstract class ITopRatedMovies {
  Future<Iterable<Movie>> getTopRatedMovies(int page);
}
