import 'package:http/http.dart';
import 'package:watched_it_2/models/tv/detailed_tv_model.dart';

abstract class ITvDetails {
  Future<DetailedTv> getTvDetails({
    required String id,
    Future<Response> Function()? dataSource,
  });
}
