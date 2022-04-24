import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_recommendations.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbMovieRecommendations implements IMovieRecommentations {
  @override
  Future<PagedResults<Movie>> getRecommendations({
    required String id,
    int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObjectImpl<PagedResults<Movie>>(
      urlGenerator: () => urlGenerator(id, page),
      jsonConverter: (json) => pagedResultsFromJson<Movie>(
        json,
        Movie.fromJson,
      ),
      dataSource: dataSource,
    ).retrieveObject();
  }
}

extension UrlGenerator on TmdbMovieRecommendations {
  String urlGenerator(String id, int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/recommendations",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
