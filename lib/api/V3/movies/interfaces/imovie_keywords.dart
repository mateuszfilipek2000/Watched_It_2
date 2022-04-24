import 'package:http/http.dart';
import 'package:watched_it_2/models/keyword_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class IMovieKeywords {
  Future<Keywords> getMovieKeywords(
    String id, {
    Future<Response> Function()? dataSource,
  });
}
