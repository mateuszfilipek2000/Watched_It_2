import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_upcoming.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

class TmdbMoviesUpcoming implements IMoviesUpcoming {
  // const TmdbMoviesUpcoming();
  @override
  Future<PagedResults<Movie>> getUpcomingMovies({
    // int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<PagedResults<Movie>>(
      urlGenerator: () => urlGenerator(1),
      jsonConverter: (json) => pagedResultsFromJson<Movie>(
        json,
        Movie.fromJson,
        urlGenerator,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMoviesUpcoming {
  String urlGenerator(int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/upcoming",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
