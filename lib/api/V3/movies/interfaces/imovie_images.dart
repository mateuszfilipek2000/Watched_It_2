import 'package:http/http.dart';
import 'package:watched_it_2/models/image_model.dart';

abstract class IMovieImages {
  Future<Images> getMovieImages(
    String id, {
    Future<Response> Function()? dataSource,
  });
}
