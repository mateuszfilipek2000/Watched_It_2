import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_top_rated.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

class TmdbMoviesTopRated implements IMoviesTopRated {
  const TmdbMoviesTopRated({this.dataSource});

  @override
  Future<PagedResults<Movie>> getTopRatedMovies({int page = 1}) async {
    return await ApiRetrieveObjectImpl<PagedResults<Movie>>(
      urlGenerator: () => urlGenerator(page),
      jsonConverter: (json) => pagedResultsFromJson<Movie>(
        json,
        Movie.fromJson,
      ),
      dataSource: dataSource,
    ).retrieveObject();
  }

  String urlGenerator(int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/top_rated",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();

  final Future<Response> Function()? dataSource;
}
