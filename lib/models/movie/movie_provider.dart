import 'package:watched_it_2/models/movie/detailed_movie_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

abstract class MovieProvider {
  Future<Iterable<Movie>> getMovies();

  Future<DetailedMovie> getMovieDetails(int id);
}
