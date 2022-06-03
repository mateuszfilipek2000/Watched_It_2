import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_on_the_air.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbTvOnTheAir implements ITvOnTheAir {
  @override
  Future<PagedResults<Tv>> getOnTheAirTv({
    // int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<PagedResults<Tv>>(
      urlGenerator: () => urlGenerator(1),
      jsonConverter: (json) => pagedResultsFromJson<Tv>(
        json,
        Tv.fromJson,
        urlGenerator,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvOnTheAir {
  String urlGenerator(int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/on_the_air",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
