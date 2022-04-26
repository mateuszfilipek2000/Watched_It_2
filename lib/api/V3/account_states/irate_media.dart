import 'package:http/http.dart';

abstract class IRateMedia<T> {
  Future<void> rateMedia(
    T media, {
    required double rating,
    required String sessionId,
    Future<Response> Function()? dataSource,
  });
}
