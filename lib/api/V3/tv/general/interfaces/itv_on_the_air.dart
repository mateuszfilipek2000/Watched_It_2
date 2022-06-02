import 'package:http/http.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';

abstract class ITvOnTheAir {
  /// returns a [PagedResults] of type [Tv], with results containing
  /// [Tv] objects from the first available page
  Future<PagedResults<Tv>> getOnTheAirTv({
    // int page = 1,
    Future<Response> Function()? dataSource,
  });
}
