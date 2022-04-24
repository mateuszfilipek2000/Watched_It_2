import 'package:http/http.dart';
import 'package:watched_it_2/models/image_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class IMovieImages {
  Future<Images> getMovieImages(
    String id, {
    Future<Response> Function()? dataSource,
  });
}
