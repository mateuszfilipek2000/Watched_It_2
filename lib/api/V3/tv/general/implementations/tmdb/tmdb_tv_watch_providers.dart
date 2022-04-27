import 'package:http/src/response.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_watch_providers.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/justwatch_watch_providers.dart';

class TmdbTvWatchProviders implements ITvWatchProviders {
  @override
  Future<JustWatchWatchProviders> getTvWatchProviders({
    required String id,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<JustWatchWatchProviders>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: JustWatchWatchProviders.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvWatchProviders {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/watch/providers",
        queryParameters: {},
      ).toString();
}
