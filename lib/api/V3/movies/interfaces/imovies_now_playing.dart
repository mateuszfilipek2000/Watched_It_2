import 'package:http/http.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

abstract class INowPlayingMovies {
  Future<PagedResults<Movie>> getNowPlayingMovies({
    int page = 1,
    Future<Response> Function()? dataSource,
  });
}
