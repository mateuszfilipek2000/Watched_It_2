import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_account_states.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_credits.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_details.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_images.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_keywords.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_lists.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_recommendations.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_reviews.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_similar.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_watch_providers.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_popular.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_top_rated.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_upcoming.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_account_states.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_credits.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_details.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_images.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_keywords.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_lists.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_recommendations.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_reviews.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_similar.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_watch_providers.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_top_rated.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_upcoming.dart';
import 'package:watched_it_2/models/account_states_model.dart';
import 'package:watched_it_2/models/image_model.dart';
import 'package:watched_it_2/models/justwatch_watch_providers.dart';
import 'package:watched_it_2/models/keyword_model.dart';
import 'package:watched_it_2/models/list_element_model.dart';
import 'package:watched_it_2/models/movie/detailed_movie_model.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/people/credits_model.dart';
import 'package:watched_it_2/models/review_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Movie Detailed", () {
    late String file;
    late IMovieDetails movieDetails;
    setUp(() async {
      // WidgetsFlutterBinding.ensureInitialized();
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_details.json",
      );
    });

    test("Retreving detailed movie, successful request", () async {
      movieDetails = TmdbMovieDetails();
      final expectedMovie = DetailedMovie.fromJson(json.decode(file));

      final generatedMovie = await movieDetails.getMovieDetails(
        "3",
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      expect(expectedMovie, generatedMovie);
    });

    test("Retreving detailed movie, successful request, fails conversion",
        () async {
      movieDetails = TmdbMovieDetails();

      expect(
          () => movieDetails.getMovieDetails(
                "",
                dataSource: () async => http.Response(
                  "",
                  200,
                ),
              ),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving detailed movie, request fails", () async {
      movieDetails = TmdbMovieDetails();
      expect(
        () => movieDetails.getMovieDetails(
          "",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Account States", () {
    late String file;
    late IMovieAccountStates movieAccountStates;
    setUp(() async {
      // WidgetsFlutterBinding.ensureInitialized();
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_account_states.json",
      );
    });

    test("Retreving account states, successful request", () async {
      movieAccountStates = TmdbMovieAccountStates();

      final expectedMovieAccountStates =
          AccountStates.fromJson(json.decode(file));

      final generatedMovieAccountStates =
          await movieAccountStates.getAccountStates(
        "3",
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      expect(expectedMovieAccountStates, generatedMovieAccountStates);
    });

    test("Retreving account states, successful request, fails conversion",
        () async {
      movieAccountStates = TmdbMovieAccountStates();

      expect(
          () => movieAccountStates.getAccountStates(
                "3",
                dataSource: () async => http.Response(
                  "",
                  200,
                ),
              ),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving account states, request fails", () async {
      movieAccountStates = TmdbMovieAccountStates();

      expect(
        () => movieAccountStates.getAccountStates(
          "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Credits", () {
    late String file;
    late IMovieCredits movieCredits;
    setUp(() async {
      // WidgetsFlutterBinding.ensureInitialized();
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_credits.json",
      );
    });

    test("Retreving movie credits, successful request", () async {
      movieCredits = TmdbMovieCredits();

      final expectedMovieCredits = Credits.fromJson(json.decode(file));

      final generatedMovieCredits = await movieCredits.getMovieCredits(
        "3",
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      expect(expectedMovieCredits, generatedMovieCredits);
    });

    test("Retreving movie credits, successful request, fails conversion",
        () async {
      movieCredits = TmdbMovieCredits();

      expect(
          () => movieCredits.getMovieCredits(
                "3",
                dataSource: () async => http.Response(
                  "",
                  200,
                ),
              ),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie credits, request fails", () async {
      movieCredits = TmdbMovieCredits();

      expect(
        () => movieCredits.getMovieCredits(
          "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Images", () {
    late String file;
    late IMovieImages interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_images.json",
      );
    });

    test("Retreving movie images, successful request", () async {
      interface = TmdbMovieImages();

      final expected = Images.fromJson(json.decode(file));

      final generated = await interface.getMovieImages(
        "3",
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      expect(expected, generated);
    });

    test("Retreving movie images, successful request, fails conversion",
        () async {
      interface = TmdbMovieImages();

      expect(
          () => interface.getMovieImages(
                "3",
                dataSource: () async => http.Response(
                  "",
                  200,
                ),
              ),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie images, request fails", () async {
      interface = TmdbMovieImages();

      expect(
        () => interface.getMovieImages(
          "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Keywords", () {
    late String file;
    late IMovieKeywords interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_keywords.json",
      );
    });

    test("Retreving movie keywords, successful request", () async {
      interface = TmdbMovieKeywords();

      final expected = Keywords.fromJson(json.decode(file));

      final generated = await interface.getMovieKeywords(
        "3",
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      expect(expected, generated);
    });

    test("Retreving movie keywords, successful request, fails conversion",
        () async {
      interface = TmdbMovieKeywords();

      expect(
          () => interface.getMovieKeywords(
                "3",
                dataSource: () async => http.Response(
                  "",
                  200,
                ),
              ),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie keywords, request fails", () async {
      interface = TmdbMovieKeywords();

      expect(
        () => interface.getMovieKeywords(
          "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Lists", () {
    late String file;
    late IMovieLists interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_lists.json",
      );
    });

    test("Retreving movie lists, successful request", () async {
      interface = TmdbMovieLists();

      final expected = ListModel.fromJson(json.decode(file));

      final generated = await interface.getMovieLists(
        id: "3",
        page: 1,
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      expect(expected, generated);
    });

    test("Retreving movie lists, successful request, fails conversion",
        () async {
      interface = TmdbMovieLists();

      expect(
          () => interface.getMovieLists(
                id: "3",
                page: 1,
                dataSource: () async => http.Response(
                  "",
                  200,
                ),
              ),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie lists, request fails", () async {
      interface = TmdbMovieLists();

      expect(
        () => interface.getMovieLists(
          id: "3",
          page: 1,
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  // ignore: non_constant_identifier_names
  String PLACEHOLDERFUNC(int page) => "";

  group("Movie Recommendations, checking if Paged Results work correctly", () {
    late String file;
    late IMovieRecommentations interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_recommendations.json",
      );
    });

    test(
        "Retreving movie recommendations, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMovieRecommendations();

      final expected = pagedResultsFromJson(
        json.decode(file),
        Movie.fromJson,
        PLACEHOLDERFUNC,
      );

      final generated = await interface.getRecommendations(
        // page: 1,
        id: "3",
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      expect(expected, generated);
    });

    test(
        "Retreving movie recommendations, successful request, fails conversion",
        () async {
      interface = TmdbMovieRecommendations();

      expect(
        () => interface.getRecommendations(
          // page: 1,
          id: "3",
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving movie recommendations, request fails", () async {
      interface = TmdbMovieRecommendations();

      expect(
        () => interface.getRecommendations(
          // page: 1,
          id: "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Reviews, checking if Paged Results work correctly", () {
    late String file;
    late IMovieReviews interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_reviews.json",
      );
    });

    test(
        "Retreving movie reviews, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMovieReviews();

      final expected = pagedResultsFromJson(
        json.decode(file),
        Review.fromJson,
        PLACEHOLDERFUNC,
      );

      final generated = await interface.getMovieReviews(
        // page: 1,
        id: "3",
        dataSource: () async => http.Response(file, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }),
      );

      expect(expected, generated);
    });

    test("Retreving movie reviews, successful request, fails conversion",
        () async {
      interface = TmdbMovieReviews();

      expect(
        () => interface.getMovieReviews(
          // page: 1,
          id: "3",
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving movie reviews, request fails", () async {
      interface = TmdbMovieReviews();

      expect(
        () => interface.getMovieReviews(
          // page: 1,
          id: "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Similar, checking if Paged Results work correctly", () {
    late String file;
    late IMovieSimilar interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_similar.json",
      );
    });

    test(
        "Retreving similar movies, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMovieSimilar();

      final expected = pagedResultsFromJson(
        json.decode(file),
        Movie.fromJson,
        PLACEHOLDERFUNC,
      );

      final generated = await interface.getSimilarMovies(
        // page: 1,
        id: "3",
        dataSource: () async => http.Response(
          file,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      expect(expected, generated);
    });

    test("Retreving similar movies, successful request, fails conversion",
        () async {
      interface = TmdbMovieSimilar();

      expect(
        () => interface.getSimilarMovies(
          // page: 1,
          id: "3",
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving similar movies, request fails", () async {
      interface = TmdbMovieSimilar();

      expect(
        () => interface.getSimilarMovies(
          // page: 1,
          id: "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movie Watch Providers", () {
    late String file;
    late IMovieWatchProviders interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_watch_providers.json",
      );
    });

    test(
        "Retreving movie watch providers, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMovieWatchProviders();

      final expected = JustWatchWatchProviders.fromJson(
        json.decode(file),
      );

      final generated = await interface.getMovieWatchProviders(
        "3",
        dataSource: () async => http.Response(
          file,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      expect(expected, generated);
    });

    test(
        "Retreving movie watch providers, successful request, fails conversion",
        () async {
      interface = TmdbMovieWatchProviders();

      expect(
        () => interface.getMovieWatchProviders(
          "3",
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving movie watch providers, request fails", () async {
      interface = TmdbMovieWatchProviders();

      expect(
        () => interface.getMovieWatchProviders(
          "3",
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movies Now Playing, checking if Paged Results work correctly", () {
    late String file;
    late INowPlayingMovies interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movies_now_playing.json",
      );
    });

    test(
        "Retreving now playing movies, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMoviesNowPlaying();

      final expected = pagedResultsFromJson(
        json.decode(file),
        Movie.fromJson,
        PLACEHOLDERFUNC,
      );

      final generated = await interface.getNowPlayingMovies(
        // page: 1,
        dataSource: () async => http.Response(
          file,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      expect(expected, generated);
    });

    test("Retreving now playing movies, successful request, fails conversion",
        () async {
      interface = TmdbMoviesNowPlaying();

      expect(
        () => interface.getNowPlayingMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving now playing movies, request fails", () async {
      interface = TmdbMoviesNowPlaying();

      expect(
        () => interface.getNowPlayingMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movies Popular, checking if Paged Results work correctly", () {
    late String file;
    late IMoviesPopular interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movies_popular.json",
      );
    });

    test(
        "Retreving popular movies, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMoviesPopular();

      final expected = pagedResultsFromJson(
        json.decode(file),
        Movie.fromJson,
        PLACEHOLDERFUNC,
      );

      final generated = await interface.getPopularMovies(
        // page: 1,
        dataSource: () async => http.Response(
          file,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      expect(expected, generated);
    });

    test("Retreving popular movies, successful request, fails conversion",
        () async {
      interface = TmdbMoviesPopular();

      expect(
        () => interface.getPopularMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving popular movies, request fails", () async {
      interface = TmdbMoviesPopular();

      expect(
        () => interface.getPopularMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movies Top Rated, checking if Paged Results work correctly", () {
    late String file;
    late IMoviesTopRated interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movies_top_rated.json",
      );
    });

    test(
        "Retreving top rated movies, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMoviesTopRated();

      final expected = pagedResultsFromJson(
        json.decode(file),
        Movie.fromJson,
        PLACEHOLDERFUNC,
      );

      final generated = await interface.getTopRatedMovies(
        // page: 1,
        dataSource: () async => http.Response(
          file,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      expect(expected, generated);
    });

    test("Retreving top rated movies, successful request, fails conversion",
        () async {
      interface = TmdbMoviesTopRated();

      expect(
        () => interface.getTopRatedMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving top rated movies, request fails", () async {
      interface = TmdbMoviesTopRated();

      expect(
        () => interface.getTopRatedMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  group("Movies Upcoming, checking if Paged Results work correctly", () {
    late String file;
    late IMoviesUpcoming interface;
    setUp(() async {
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movies_upcoming.json",
      );
    });

    test(
        "Retreving upcoming movies, successful request, should correctly parse paged results",
        () async {
      interface = TmdbMoviesUpcoming();

      final expected = pagedResultsFromJson(
        json.decode(file),
        Movie.fromJson,
        PLACEHOLDERFUNC,
      );

      final generated = await interface.getUpcomingMovies(
        // page: 1,
        dataSource: () async => http.Response(
          file,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      expect(expected, generated);
    });

    test("Retreving upcoming movies, successful request, fails conversion",
        () async {
      interface = TmdbMoviesUpcoming();

      expect(
        () => interface.getUpcomingMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "",
            200,
          ),
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving upcoming movies, request fails", () async {
      interface = TmdbMoviesUpcoming();

      expect(
        () => interface.getUpcomingMovies(
          // page: 1,
          dataSource: () async => http.Response(
            "fail",
            404,
          ),
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });
}

// TODO THINK OF A WAY TO GENERATE THESE TESTS
/// generate test for retrieving data from api
// void generateTest<T, IType, ImplType>(
//   String jsonLocation,
// ) {
//   group("${T.runtimeType}", () {
//     late String file;
//     late IMovieCredits movieCredits;
//     setUp(() async {
//       WidgetsFlutterBinding.ensureInitialized();
//       file = await rootBundle.loadString(
//         jsonLocation,
//       );
//     });

//     test("Retreving movie credits, successful request", () async {
//       movieCredits = TmdbMovieCredits(
//         dataSource: () async => http.Response(
//           file,
//           200,
//         ),
//       );

//       final expectedMovieCredits = Credits.fromJson(json.decode(file));

//       final generatedMovieCredits = await movieCredits.getMovieCredits("3");

//       expect(expectedMovieCredits, generatedMovieCredits);
//     });

//     test("Retreving movie credits, successful request, fails conversion",
//         () async {
//       movieCredits = TmdbMovieCredits(
//         dataSource: () async => http.Response(
//           "",
//           200,
//         ),
//       );

//       expect(() => movieCredits.getMovieCredits("3"),
//           throwsA(isA<ApiResponseObjectConversionError>()));
//     });

//     test("Retreving movie credits, request fails", () async {
//       movieCredits = TmdbMovieCredits(
//         dataSource: () async => http.Response(
//           "fail",
//           404,
//         ),
//       );

//       expect(
//         () => movieCredits.getMovieCredits("3"),
//         throwsA(
//           isA<ApiRequestFailedError>(),
//         ),
//       );
//     });
//   });
// }
