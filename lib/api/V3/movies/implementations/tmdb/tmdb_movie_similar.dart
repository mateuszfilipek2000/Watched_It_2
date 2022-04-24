import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_similar.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/models/paged_results_model.dart';

@immutable
class TmdbMovieSimilar implements IMovieSimilar {
  const TmdbMovieSimilar({this.dataSource});

  @override
  Future<PagedResults<Movie>> getSimilarMovies({
    required String id,
    int page = 1,
  }) async {
    return await ApiRetrieveObjectImpl<PagedResults<Movie>>(
      urlGenerator: () => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/similar",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString(),
      jsonConverter: (json) => pagedResultsFromJson<Movie>(
        json,
        Movie.fromJson,
      ),
      dataSource: dataSource,
    ).retrieveObject();
  }

  final Future<Response> Function()? dataSource;
}
