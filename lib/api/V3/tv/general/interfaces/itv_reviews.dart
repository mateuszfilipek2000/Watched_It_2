import 'package:http/http.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/review_model.dart';

abstract class ITvReviews {
  /// returns a [PagedResults] of type [Review], with results containing
  /// [Review] objects from the first available page
  Future<PagedResults<Review>> getTvReviews({
    // int page = 1,
    required String id,
    Future<Response> Function()? dataSource,
  });
}
