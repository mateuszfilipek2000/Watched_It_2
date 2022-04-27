import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_keywords.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/keyword_model.dart';

class TmdbMovieKeywords implements IMovieKeywords {
  @override
  Future<Keywords> getMovieKeywords(
    String id, {
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<Keywords>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: Keywords.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMovieKeywords {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/keywords",
        queryParameters: {},
      ).toString();
}
