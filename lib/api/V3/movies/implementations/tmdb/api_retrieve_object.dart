import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

typedef DataSource = Future<http.Response> Function();
typedef UrlGenerator = String Function();
typedef JsonConverter<T> = T Function(Map<String, dynamic>);
typedef JsonFormatter = Map<String, dynamic> Function(Map<String, dynamic>);

abstract class IApiRetrieveObject<T> {
  Future<T> retrieveObject();
}

enum HttpMethod {
  get,
  post,
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
    this.jsonFormatter,
  });

  @override
  Future<T> retrieveObject({
    HttpMethod httpMethod = HttpMethod.get,
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    late http.Response response;

    switch (httpMethod) {
      case HttpMethod.get:
        response = await (dataSource != null
            ? dataSource!()
            : http.get(
                Uri.parse(
                  urlGenerator(),
                ),
              ));
        break;
      case HttpMethod.post:
        response = await (dataSource != null
            ? dataSource!()
            : http.post(
                Uri.parse(urlGenerator()),
                headers: headers,
                body: body,
              ));
        break;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        // TODO CHECK IF JSON FORMATTER WORKS
        final decodedResponse = jsonFormatter == null
            ? json.decode(response.body)
            : jsonFormatter!(
                json.decode(response.body),
              );
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

  /// if json generated by response is nested, you need to format it properly before it's used.
  /// For example, you can make json converter target different key in json provided by response
  final JsonFormatter? jsonFormatter;
}
