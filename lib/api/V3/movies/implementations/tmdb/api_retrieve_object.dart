import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

typedef DataSource = Future<http.Response> Function();
typedef UrlGenerator = String Function();
typedef JsonConverter<T> = T Function(Map<String, dynamic>);

abstract class IApiRetrieveObject<T> {
  Future<T> retrieveObject();
}

class ApiResponseObjectConversionError {
  const ApiResponseObjectConversionError(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class ApiRequestFailedError {
  const ApiRequestFailedError(this.response);

  final http.Response response;

  @override
  String toString() {
    return response.toString();
  }
}

class ApiRetrieveObjectImpl<T> implements IApiRetrieveObject<T> {
  const ApiRetrieveObjectImpl({
    required this.urlGenerator,
    required this.jsonConverter,
    this.dataSource,
  });

  @override
  Future<T> retrieveObject() async {
    final response = await (dataSource != null
        ? dataSource!()
        : http.get(
            Uri.parse(
              urlGenerator(),
            ),
          ));

    if (response.statusCode == 200) {
      try {
        final decodedResponse = json.decode(response.body);
        return jsonConverter(decodedResponse);
      } catch (e) {
        log("Couldn't retrieve details of ${T.runtimeType}");
        log(e.toString());
        log(response.toString());
        throw ApiResponseObjectConversionError(e.toString());
      }
    }
    log("Request failed while trying to retrieve the details of ${T.runtimeType}");
    log(response.toString());
    throw ApiRequestFailedError(response);
  }

  final UrlGenerator urlGenerator;
  final JsonConverter<T> jsonConverter;
  final DataSource? dataSource;
}
