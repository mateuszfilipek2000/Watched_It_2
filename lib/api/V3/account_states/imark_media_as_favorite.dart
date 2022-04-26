import 'package:http/http.dart';

abstract class IMarkMediaAsFavorite<T> {
  /// if you want to mark media as favorite, pass true as favorite
  /// argument, if you want to delete media from favorite, pass false
  Future<void> markMediaAsFavorite(
    T object, {
    bool favorite,
    Future<Response> Function()? dataSource,
  });
}
