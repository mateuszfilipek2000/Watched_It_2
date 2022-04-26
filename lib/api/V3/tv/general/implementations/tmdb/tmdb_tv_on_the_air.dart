import 'package:http/src/response.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_on_the_air.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbTvOnTheAir implements ITvOnTheAir {
  @override
  Future<PagedResults<Tv>> getOnTheAirTv(
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

extension UrlGenerator on TmdbTvOnTheAir {
  String urlGenerator() => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/on_the_air",
        queryParameters: {},
      ).toString();
}
