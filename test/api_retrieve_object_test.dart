import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_account_states.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_credits.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_details.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_images.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_keywords.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_lists.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_recommendations.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_reviews.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_account_states.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_credits.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_details.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_images.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_keywords.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_lists.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_recommendations.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_reviews.dart';
import 'package:watched_it_2/models/account_states_model.dart';
import 'package:watched_it_2/models/image_model.dart';
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
      movieDetails = TmdbMovieDetails(
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );
      // final impl = ApiRetrieveObjectImpl<DetailedMovie>(
      //   urlGenerator: () => "",
      //   jsonConverter: DetailedMovie.fromJson,
      //   dataSource: () async => http.Response(
      //     file,
      //     200,
      //   ),
      // );

      final expectedMovie = DetailedMovie.fromJson(json.decode(file));

      final generatedMovie = await movieDetails.getMovieDetails("3");

      expect(expectedMovie, generatedMovie);
    });

    test("Retreving detailed movie, successful request, fails conversion",
        () async {
      movieDetails = TmdbMovieDetails(
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );
      // final impl = ApiRetrieveObjectImpl<DetailedMovie>(
      //   urlGenerator: () => "",
      //   jsonConverter: DetailedMovie.fromJson,
      //   dataSource: () async => http.Response(
      //     "",
      //     200,
      //   ),
      // );

      expect(() => movieDetails.getMovieDetails(""),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving detailed movie, request fails", () async {
      movieDetails = TmdbMovieDetails(
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );
      // final impl = ApiRetrieveObjectImpl<DetailedMovie>(
      //   urlGenerator: () => "",
      //   jsonConverter: DetailedMovie.fromJson,
      //   dataSource: () async => http.Response(
      //     "fail",
      //     404,
      //   ),
      // );

      expect(
        () => movieDetails.getMovieDetails(""),
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
      movieAccountStates = TmdbMovieAccountStates(
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      final expectedMovieAccountStates =
          AccountStates.fromJson(json.decode(file));

      final generatedMovieAccountStates =
          await movieAccountStates.getAccountStates("3");

      expect(expectedMovieAccountStates, generatedMovieAccountStates);
    });

    test("Retreving account states, successful request, fails conversion",
        () async {
      movieAccountStates = TmdbMovieAccountStates(
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(() => movieAccountStates.getAccountStates("3"),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving account states, request fails", () async {
      movieAccountStates = TmdbMovieAccountStates(
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
        () => movieAccountStates.getAccountStates("3"),
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
      movieCredits = TmdbMovieCredits(
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      final expectedMovieCredits = Credits.fromJson(json.decode(file));

      final generatedMovieCredits = await movieCredits.getMovieCredits("3");

      expect(expectedMovieCredits, generatedMovieCredits);
    });

    test("Retreving movie credits, successful request, fails conversion",
        () async {
      movieCredits = TmdbMovieCredits(
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(() => movieCredits.getMovieCredits("3"),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie credits, request fails", () async {
      movieCredits = TmdbMovieCredits(
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
        () => movieCredits.getMovieCredits("3"),
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
      interface = TmdbMovieImages(
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      final expected = Images.fromJson(json.decode(file));

      final generated = await interface.getMovieImages("3");

      expect(expected, generated);
    });

    test("Retreving movie images, successful request, fails conversion",
        () async {
      interface = TmdbMovieImages(
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(() => interface.getMovieImages("3"),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie images, request fails", () async {
      interface = TmdbMovieImages(
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
        () => interface.getMovieImages("3"),
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
      interface = TmdbMovieKeywords(
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      final expected = Keywords.fromJson(json.decode(file));

      final generated = await interface.getMovieKeywords("3");

      expect(expected, generated);
    });

    test("Retreving movie keywords, successful request, fails conversion",
        () async {
      interface = TmdbMovieKeywords(
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(() => interface.getMovieKeywords("3"),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie keywords, request fails", () async {
      interface = TmdbMovieKeywords(
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
        () => interface.getMovieKeywords("3"),
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
      interface = TmdbMovieLists(
        page: 1,
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      final expected = ListModel.fromJson(json.decode(file));

      final generated = await interface.getMovieLists("3");

      expect(expected, generated);
    });

    test("Retreving movie lists, successful request, fails conversion",
        () async {
      interface = TmdbMovieLists(
        page: 1,
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(() => interface.getMovieLists("3"),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving movie lists, request fails", () async {
      interface = TmdbMovieLists(
        page: 1,
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
        () => interface.getMovieLists("3"),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

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
      interface = TmdbMovieRecommendations(
        // page: 1,
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      final expected = pagedResultsFromJson(
        json.decode(file),
        Movie.fromJson,
      );

      final generated = await interface.getRecommendations(
        page: 1,
        id: "3",
      );

      expect(expected, generated);
    });

    test(
        "Retreving movie recommendations, successful request, fails conversion",
        () async {
      interface = TmdbMovieRecommendations(
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(
        () => interface.getRecommendations(
          page: 1,
          id: "3",
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving movie recommendations, request fails", () async {
      interface = TmdbMovieRecommendations(
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
        () => interface.getRecommendations(
          page: 1,
          id: "3",
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
      interface = TmdbMovieReviews(
        dataSource: () async => http.Response(file, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }),
      );

      final expected = pagedResultsFromJson(
        json.decode(file),
        Review.fromJson,
      );

      final generated = await interface.getMovieReviews(
        page: 1,
        id: "3",
      );

      expect(expected, generated);
    });

    test("Retreving movie reviews, successful request, fails conversion",
        () async {
      interface = TmdbMovieReviews(
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(
        () => interface.getMovieReviews(
          page: 1,
          id: "3",
        ),
        throwsA(isA<ApiResponseObjectConversionError>()),
      );
    });

    test("Retreving movie reviews, request fails", () async {
      interface = TmdbMovieReviews(
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
        () => interface.getMovieReviews(
          page: 1,
          id: "3",
        ),
        throwsA(
          isA<ApiRequestFailedError>(),
        ),
      );
    });
  });

  // generateTest<int>(3);
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
