import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';

/// if rating needs more parameters, then you can pass them using
/// the optional parameters, make sure to make use of them while
/// implementing the rating handler
abstract class IRateMedia<T> {
  Future<void> rateMedia({
    required T media,
    required double rating,
    required String sessionId,
    required String url,
    Map<String, String>? optionalParameters,
    Future<Response> Function()? dataSource,
  });
}

///generic rate method used for media rating,
///pass rating and url as parameters
///if request fails an exception is thrown
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
