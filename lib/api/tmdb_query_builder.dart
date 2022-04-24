import 'package:watched_it_2/core/config/api_keys.dart';

class TmdbQueryBuilder {
  const TmdbQueryBuilder._();

  static Uri buildUri({
    String scheme = "https",
    String host = "api.themoviedb.org",
    String language = "en_US",
    required TmdbApiVersion version,
    required String path,
    required Map<String, String> queryParameters,
  }) {
    return Uri(
      scheme: scheme,
      host: host,
      path: version.name + path,
      queryParameters: {
        "api_key": kApiKeyV3,
        "language": language,
      }..addAll(queryParameters),
    );
  }
}

enum TmdbApiVersion {
  v3,
  v4,
}

extension ApiVersionString on TmdbApiVersion {
  String get version {
    switch (this) {
      case TmdbApiVersion.v3:
        return "/3/";

      case TmdbApiVersion.v4:
        return "/4/";
    }
  }
}
