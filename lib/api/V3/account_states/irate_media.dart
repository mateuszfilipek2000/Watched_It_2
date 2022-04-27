import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';

abstract class IRateMedia<T> {
  Future<void> rateMedia({
    required T media,
    required double rating,
    required String sessionId,
    required String url,
    Future<Response> Function()? dataSource,
  });
}

Future<void> rate<T>({
  required double rating,
  required String url,
  Future<Response> Function()? dataSource,
}) async {
  int statusCode = await ApiRetrieveObject.retrieveObject<int>(
    urlGenerator: () => url,
    jsonConverter: (json) => json["status_code"],
    dataSource: dataSource,
    httpMethod: HttpMethod.post,
    body: {
      "value": rating.toString(),
    },
  );
  if (statusCode == 1) {
    return;
  }
  //TODO THROW LESS GENERIC EXCEPTION
  throw Exception(
    "Failed to rate ${T.runtimeType}",
  );
}
