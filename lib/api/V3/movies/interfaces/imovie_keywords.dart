import 'package:http/http.dart';
import 'package:watched_it_2/models/keyword_model.dart';

abstract class IMovieKeywords {
  Future<Keywords> getMovieKeywords(
    String id, {
    Future<Response> Function()? dataSource,
  });
}
