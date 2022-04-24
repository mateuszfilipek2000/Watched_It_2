import 'package:http/http.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';

abstract class ITvTopRated {
  Future<PagedResults<Tv>> getTopRatedTv({
    int page = 1,
    Future<Response> Function()? dataSource,
  });
}