import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_images.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/image_model.dart';

class TmdbTvImages implements ITvImages {
  @override
  Future<Images> getTvImages(
      {required String id, Future<Response> Function()? dataSource}) async {
    return await ApiRetrieveObject.retrieveObject<Images>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: Images.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvImages {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/images",
        queryParameters: {},
      ).toString();
}
