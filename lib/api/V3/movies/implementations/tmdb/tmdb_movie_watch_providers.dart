import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_watch_providers.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/justwatch_watch_providers.dart';

class TmdbMovieWatchProviders implements IMovieWatchProviders {
  @override
  Future<JustWatchWatchProviders> getMovieWatchProviders(
    String id, {
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<JustWatchWatchProviders>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: JustWatchWatchProviders.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMovieWatchProviders {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/watch/providers",
        queryParameters: {},
      ).toString();
}
