import 'package:http/http.dart';
import 'package:watched_it_2/models/tv/tv_aggregate_credits_model.dart';

abstract class ITvAggregateCredits {
  Future<TvAggregatedCredits> getTvAggregatedCredits({
    required String id,
    Future<Response> Function()? dataSource,
  });
}
