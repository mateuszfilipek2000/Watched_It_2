import 'package:http/http.dart';
import 'package:watched_it_2/models/people/credits_model.dart';

abstract class IMovieCredits {
  Future<Credits> getMovieCredits(
    String id, {
    Future<Response> Function()? dataSource,
  });
}
