import 'package:http/http.dart';
import 'package:watched_it_2/models/justwatch_watch_providers.dart';

abstract class IMovieWatchProviders {
  Future<JustWatchWatchProviders> getMovieWatchProviders(
    String id, {
    Future<Response> Function()? dataSource,
  });
}
