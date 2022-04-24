import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

abstract class IMoviesTopRated {
  Future<PagedResults<Movie>> getTopRatedMovies({
    int page = 1,
  });
}
