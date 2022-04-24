import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_images.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/image_model.dart';

class TmdbMovieImages implements IMovieImages {
  @override
  Future<Images> getMovieImages(
    String id, {
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObjectImpl<Images>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: Images.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }
}

extension UrlGenerator on TmdbMovieImages {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/images",
        queryParameters: {},
      ).toString();
}
