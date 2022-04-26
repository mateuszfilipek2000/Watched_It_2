import 'package:http/http.dart';

/// use only on movie/tv
abstract class IDeleteMediaRating<T> {
  Future<void> deleteMediaRating(
    T media, {
    Future<Response> Function()? dataSource,
  });
}
