import 'package:flutter_test/flutter_test.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_popular.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_top_rated.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_upcoming.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/core/config/api_keys.dart';

void main() {
  group("Query Builder tests", () {
    const String id = "3";
    const int page = 1;

    test("testing for movie reviews url", () {
      const String expected =
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
      const String expected =
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

    test("testing for movie similar url", () {
      const String expected =
          "https://api.themoviedb.org/3/movie/$id/similar?api_key=$kApiKeyV3&language=en-US&page=$page";

      final String created = TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/similar",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();

      expect(expected, created);
    });

    test("testing for movie watch providers url", () {
      const String expected =
          "https://api.themoviedb.org/3/movie/$id/watch/providers?api_key=$kApiKeyV3&language=en-US";

      final String created = TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/watch/providers",
        queryParameters: {},
      ).toString();

      expect(expected, created);
    });

    test("testing for now playing movies url", () {
      const String expected =
          "https://api.themoviedb.org/3/movie/now_playing?api_key=$kApiKeyV3&language=en-US&page=$page";

      final String created = TmdbMoviesNowPlaying().urlGenerator(page);

      expect(expected, created);
    });

    test("testing for popular movies url", () {
      const String expected =
          "https://api.themoviedb.org/3/movie/popular?api_key=$kApiKeyV3&language=en-US&page=$page";

      final String created = TmdbMoviesPopular().urlGenerator(page);

      expect(expected, created);
    });

    test("testing for top rated movies url", () {
      const String expected =
          "https://api.themoviedb.org/3/movie/top_rated?api_key=$kApiKeyV3&language=en-US&page=$page";

      final String created = TmdbMoviesTopRated().urlGenerator(page);

      expect(expected, created);
    });

    test("testing for upcoming movies url", () {
      const String expected =
          "https://api.themoviedb.org/3/movie/upcoming?api_key=$kApiKeyV3&language=en-US&page=$page";

      final String created = TmdbMoviesUpcoming().urlGenerator(page);

      expect(expected, created);
    });
  });
}
