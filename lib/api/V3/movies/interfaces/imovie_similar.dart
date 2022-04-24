import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

abstract class IMovieSimilar {
  Future<PagedResults<Movie>> getSimilarMovies({
    required String id,
    int page = 1,
  });
}
