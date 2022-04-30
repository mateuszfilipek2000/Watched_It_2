import 'package:http/http.dart';

abstract class IAddMediaToWatchlist<T> {
  /// if you want to add media to watchlist, pass true as watchlist
  /// argument, if you want to delete media from watchlist, pass false
  Future<void> addMediaToWatchlist(
    T object, {
    bool watchlist,
    Future<Response> Function()? dataSource,
  });
}
