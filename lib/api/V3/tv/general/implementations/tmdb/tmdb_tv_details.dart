import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_details.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/detailed_tv_model.dart';

class TmdbTvDetails implements ITvDetails {
  @override
  Future<DetailedTv> getTvDetails({
    required String id,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObject.retrieveObject<DetailedTv>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: DetailedTv.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvDetails {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id",
        queryParameters: {},
      ).toString();
}
