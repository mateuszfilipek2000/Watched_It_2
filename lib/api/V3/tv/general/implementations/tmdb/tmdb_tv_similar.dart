import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_similar.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbTvSimilar implements ITvSimilar {
  @override
  Future<PagedResults<Tv>> getSimilar({
    required String id,
    // int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<PagedResults<Tv>>(
      urlGenerator: () => urlGenerator(id, 1),
      jsonConverter: (json) => pagedResultsFromJson<Tv>(
        json,
        Tv.fromJson,
        (int page) => urlGenerator(id, page),
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvSimilar {
  String urlGenerator(String id, int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/similar",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
