import 'package:http/http.dart';
import 'package:watched_it_2/models/justwatch_watch_providers.dart';

abstract class ITvWatchProviders {
  Future<JustWatchWatchProviders> getTvWatchProviders({
    required String id,
    Future<Response> Function()? dataSource,
  });
}
