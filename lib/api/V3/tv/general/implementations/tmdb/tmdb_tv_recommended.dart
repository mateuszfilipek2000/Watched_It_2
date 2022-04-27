import 'package:http/src/response.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_recommendations.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbTvRecommended implements ITvRecommendations {
  @override
  Future<PagedResults<Tv>> getRecommendations({
    required String id,
    int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<PagedResults<Tv>>(
      urlGenerator: () => urlGenerator(id, page),
      jsonConverter: (json) => pagedResultsFromJson<Tv>(
        json,
        Tv.fromJson,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvRecommended {
  String urlGenerator(String id, int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/recommendations",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}