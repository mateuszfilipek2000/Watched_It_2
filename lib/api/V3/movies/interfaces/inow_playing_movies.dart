import 'package:watched_it_2/models/movie/movie_model.dart';

abstract class INowPlayingMovies {
  Future<Iterable<Movie>> getNowPlayingMovies(int page);
}
