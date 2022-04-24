import 'package:flutter/foundation.dart' show immutable;
import 'package:http/http.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/review_model.dart';

@immutable
abstract class IMovieReviews {
  Future<PagedResults<Review>> getMovieReviews({
    int page = 1,
    required String id,
    Future<Response> Function()? dataSource,
  });
}
