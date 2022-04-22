import 'package:watched_it_2/models/movie/detailed_movie_model.dart';

abstract class IMovieDetails {
  Future<DetailedMovie> getMovieDetails(String id);
}
