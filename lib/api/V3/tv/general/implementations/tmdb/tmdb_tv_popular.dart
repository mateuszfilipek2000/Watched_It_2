import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_popular.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbTvPopular implements ITvPopular {
  @override
  Future<PagedResults<Tv>> getPopularTv(
      {int page = 1, Future<Response> Function()? dataSource}) async {
    return await ApiRetrieveObject.retrieveObject<PagedResults<Tv>>(
      urlGenerator: () => urlGenerator(),
      jsonConverter: (json) => pagedResultsFromJson<Tv>(
        json,
        Tv.fromJson,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvPopular {
  String urlGenerator() => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/popular",
        queryParameters: {},
      ).toString();
}
