import 'package:flutter_test/flutter_test.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/core/config/api_keys.dart';

void main() {
  group("Query Builder tests", () {
    final String id = "3";
    final int page = 1;

    test("testing for movie reviews url", () {
      final String expected =
          "https://api.themoviedb.org/3/movie/$id/reviews?api_key=$kApiKeyV3&language=en-US&page=$page";

      final String created = TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/reviews",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();

      expect(expected, created);
    });

    test("testing for movie recommendations url", () {
      final String expected =
          "https://api.themoviedb.org/3/movie/$id/recommendations?api_key=$kApiKeyV3&language=en-US&page=$page";

      final String created = TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/recommendations",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();

      expect(expected, created);
    });
  });
}
