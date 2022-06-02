import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_similar.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbMovieSimilar implements IMovieSimilar {
  @override
  Future<PagedResults<Movie>> getSimilarMovies({
    required String id,
    // int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<PagedResults<Movie>>(
      urlGenerator: () => urlGenerator(id, 1),
      jsonConverter: (json) => pagedResultsFromJson<Movie>(
        json,
        Movie.fromJson,
        (int page) => urlGenerator(id, page),
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMovieSimilar {
  String urlGenerator(String id, int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/similar",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
