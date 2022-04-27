import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

class TmdbMoviesPopular implements IMoviesPopular {
  // const TmdbMoviesPopular();
  @override
  Future<PagedResults<Movie>> getPopularMovies({
    int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<PagedResults<Movie>>(
      urlGenerator: () => urlGenerator(page),
      jsonConverter: (json) => pagedResultsFromJson<Movie>(
        json,
        Movie.fromJson,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMoviesPopular {
  String urlGenerator(int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/popular",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
