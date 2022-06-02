import 'package:http/http.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

abstract class IMoviesPopular {
  /// returns a [PagedResults] of type [Movie], with results containing
  /// [Movie] objects from the first available page
  Future<PagedResults<Movie>> getPopularMovies({
    // int page = 1,
    Future<Response> Function()? dataSource,
  });
}
