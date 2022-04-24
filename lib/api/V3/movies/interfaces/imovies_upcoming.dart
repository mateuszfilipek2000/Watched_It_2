import 'package:watched_it_2/models/movie/movie_model.dart';

abstract class IUpcomingMovies {
  Future<Iterable<Movie>> getUpcomingMovies(int page);
}
