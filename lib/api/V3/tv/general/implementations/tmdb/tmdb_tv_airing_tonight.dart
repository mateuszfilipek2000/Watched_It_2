import 'package:http/src/response.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_airing_tonight.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbAiringTonight implements ITvAiringTonight {
  @override
  Future<PagedResults<Tv>> getAiringTonightTv(
      {int page = 1, Future<Response> Function()? dataSource}) async {
    return await ApiRetrieveObjectImpl<PagedResults<Tv>>(
      urlGenerator: () => urlGenerator(),
      jsonConverter: (json) => pagedResultsFromJson<Tv>(
        json,
        Tv.fromJson,
      ),
      dataSource: dataSource,
    ).retrieveObject();
  }
}

extension UrlGenerator on TmdbAiringTonight {
  String urlGenerator() => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/airing_today",
        queryParameters: {},
      ).toString();
}
