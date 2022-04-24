import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_reviews.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/review_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbMovieReviews implements IMovieReviews {
  @override
  Future<PagedResults<Review>> getMovieReviews({
    required String id,
    int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObjectImpl<PagedResults<Review>>(
      urlGenerator: () => urlGenerator(id, page),
      jsonConverter: (json) => pagedResultsFromJson<Review>(
        json,
        Review.fromJson,
      ),
      dataSource: dataSource,
    ).retrieveObject();
  }
}

extension UrlGenerator on TmdbMovieReviews {
  String urlGenerator(String id, int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/reviews",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
