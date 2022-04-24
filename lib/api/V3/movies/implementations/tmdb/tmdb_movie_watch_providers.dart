import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_watch_providers.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/justwatch_watch_providers.dart';

class TmdbMovieWatchProviders implements IMovieWatchProviders {
  const TmdbMovieWatchProviders({this.dataSource});

  @override
  Future<JustWatchWatchProviders> getMovieWatchProviders(String id) async {
    return await ApiRetrieveObjectImpl<JustWatchWatchProviders>(
      urlGenerator: () => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/watch/providers",
        queryParameters: {},
      ).toString(),
      jsonConverter: JustWatchWatchProviders.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }

  final Future<Response> Function()? dataSource;
}
