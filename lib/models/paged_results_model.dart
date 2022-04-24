import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';

PagedResults<T> pagedResultsFromJson<T>(
  Map<String, dynamic> json,
  JsonConverter<T> jsonResultConverter,
) =>
    PagedResults<T>(
      page: json["page"],
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
      results: List<T>.from(
        json["results"].map(
          (e) => jsonResultConverter(e),
        ),
      ),
    );

@immutable
class PagedResults<T> with EquatableMixin {
  const PagedResults({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
    // required this.jsonResultConverter,
  });

  final int page;
  final int totalPages;
  final int totalResults;
  final List<T> results;
  // final JsonConverter<T> jsonResultConverter;

  // factory PagedResults.fromJson(
  //   Map<String, dynamic> json,
  //   JsonConverter<T> jsonResultConverter,
  // ) =>
  //     PagedResults<T>(
  //       page: json["page"],
  //       totalPages: json["total_pages"],
  //       totalResults: json["total_results"],
  //       results: List<T>.from(
  //         json["results"].map(
  //           (e) => jsonResultConverter(e),
  //         ),
  //       ),
  //     );

  /// ??? CHECKING ONLY FIRST RESULT FOR EQUALITY TO AVOID
  /// UNNECESSARY CHECKING, SHOULD BE GOOD ENOUGH
  @override
  List<Object?> get props => [
        page,
        totalPages,
        totalResults,
        results[0],
      ];
}
