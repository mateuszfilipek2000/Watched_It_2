import 'package:equatable/equatable.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';

/// this function should return
typedef CreateFetchResultsUrl = String Function(int);

PagedResults<T> pagedResultsFromJson<T>(
  Map<String, dynamic> json,
  JsonConverter<T> jsonResultConverter,
  CreateFetchResultsUrl fetchPage,
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
      fetchPage: fetchPage,
      converter: jsonResultConverter,
    );

/// Thrown if user asks for a page that's outside of acceptable range
class WrongPageException implements Exception {
  final String cause;
  const WrongPageException(this.cause);
}

/// PagedResults<T> should be used if the api returns list of results of some type T
/// where the results are divided into individual pages
///
/// results are cached, if user asks for a page that's already been provided
/// at some point - no api call will be made, cached result will be returned
class PagedResults<T> with EquatableMixin {
  PagedResults({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required List<T> results,
    required this.fetchPage,
    required this.converter,
  }) {
    _results.add(results);
  }

  int page;
  final int totalPages;
  final int totalResults;
  // final List<T> results;
  final CreateFetchResultsUrl fetchPage;
  final JsonConverter<T> converter;

  final List<List<T>> _results = [];

  List<T> get results => _results[page];

  Future<List<T>> loadPage(int page) async {
    if (page < 1) {
      throw const WrongPageException("Page can't be lower than 1");
    }
    if (page > totalPages) {
      throw WrongPageException(
        "Page number can't be higher than $totalPages, asked for $page",
      );
    }
    if (page - 1 >= _results.length) {
      return _results[page - 1];
    }

    // creating new paged results object using new page index (reusing existing json converter)
    final fetchedResults =
        await ApiRetrieveObject.retrieveObject<PagedResults<T>>(
      urlGenerator: () => fetchPage(page),
      jsonConverter: (json) => pagedResultsFromJson<T>(
        json,
        converter,
        fetchPage,
      ),
    );
    // extracting results from the acquired paged results object
    _results.add(fetchedResults.results);

    this.page = page;

    return _results[page - 1];
  }

  Future<List<T>> nextPage() async => await loadPage(page + 1);

  Future<List<T>> previousPage() async => await loadPage(page - 1);

  /// ??? CHECKING ONLY FIRST RESULT FOR EQUALITY TO AVOID
  /// UNNECESSARY CHECKING, SHOULD BE GOOD ENOUGH
  @override
  List<Object?> get props => [
        page,
        totalPages,
        totalResults,
        _results.isNotEmpty ? _results[0] : _results,
      ];
}
