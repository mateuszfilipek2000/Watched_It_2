import 'package:http/src/response.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_images.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/image_model.dart';

class TmdbTvImages implements ITvImages {
  @override
  Future<Images> getTvImages(
      {required String id, Future<Response> Function()? dataSource}) async {
    return await ApiRetrieveObjectImpl<Images>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: Images.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }
}

extension UrlGenerator on TmdbTvImages {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/images",
        queryParameters: {},
      ).toString();
}
