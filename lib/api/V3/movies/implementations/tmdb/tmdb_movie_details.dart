import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_details.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/movie/detailed_movie_model.dart';

class TmdbMovieDetails implements IMovieDetails {
  @override
  Future<DetailedMovie> getMovieDetails(
    String id, {
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<DetailedMovie>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: DetailedMovie.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMovieDetails {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id",
        queryParameters: {},
      ).toString();
}
