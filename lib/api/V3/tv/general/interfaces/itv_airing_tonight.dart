import 'package:http/http.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';

/// returns a [PagedResults] of type [Tv], with results containing
/// [Tv] objects from the first available page
abstract class ITvAiringTonight {
  Future<PagedResults<Tv>> getAiringTonightTv({
    // int page = 1,
    Future<Response> Function()? dataSource,
  });
}
