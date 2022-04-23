import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/models/movie/detailed_movie_model.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;

void main() {
  group("Movie", () {
    late String file;
    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      file = await rootBundle.loadString(
        "assets/example_responses/movie/tmdb_get_movie_details.json",
      );
    });

    test("Retreving detailed movie, successful request", () async {
      final impl = ApiRetrieveObjectImpl<DetailedMovie>(
        urlGenerator: () => "",
        jsonConverter: DetailedMovie.fromJson,
        dataSource: () async => http.Response(
          file,
          200,
        ),
      );

      final expectedMovie = DetailedMovie.fromJson(json.decode(file));

      final generatedMovie = await impl.retrieveObject();

      expect(expectedMovie, generatedMovie);
    });

    test("Retreving detailed movie, successful request, fails conversion",
        () async {
      final impl = ApiRetrieveObjectImpl<DetailedMovie>(
        urlGenerator: () => "",
        jsonConverter: DetailedMovie.fromJson,
        dataSource: () async => http.Response(
          "",
          200,
        ),
      );

      expect(() => impl.retrieveObject(),
          throwsA(isA<ApiResponseObjectConversionError>()));
    });

    test("Retreving detailed movie, request fails", () async {
      final impl = ApiRetrieveObjectImpl<DetailedMovie>(
        urlGenerator: () => "",
        jsonConverter: DetailedMovie.fromJson,
        dataSource: () async => http.Response(
          "fail",
          404,
        ),
      );

      expect(
          () => impl.retrieveObject(), throwsA(isA<ApiRequestFailedError>()));
    });
  });
}
