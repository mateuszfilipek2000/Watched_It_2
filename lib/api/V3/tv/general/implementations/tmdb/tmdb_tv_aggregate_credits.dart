import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_aggregate_credits.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_aggregate_credits_model.dart';

class TmdbTvAggregateCredits implements ITvAggregateCredits {
  @override
  Future<TvAggregatedCredits> getTvAggregatedCredits({
    required String id,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<TvAggregatedCredits>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: TvAggregatedCredits.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvAggregateCredits {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/aggregate_credits",
        queryParameters: {},
      ).toString();
}
