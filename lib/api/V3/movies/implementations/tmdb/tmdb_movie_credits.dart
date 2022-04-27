import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_credits.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/people/credits_model.dart';

class TmdbMovieCredits implements IMovieCredits {
  @override
  Future<Credits> getMovieCredits(
    String id, {
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<Credits>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: Credits.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMovieCredits {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/credits",
        queryParameters: {},
      ).toString();
}
