import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_keywords.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/keyword_model.dart';

class TmdbTvKeywords implements ITvKeywords {
  @override
  Future<Keywords> getTvKeywords(
      {required String id, Future<Response> Function()? dataSource}) async {
    return await ApiRetrieveObject.retrieveObject<Keywords>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: Keywords.fromJson,
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvKeywords {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/keywords",
        queryParameters: {},
      ).toString();
}
