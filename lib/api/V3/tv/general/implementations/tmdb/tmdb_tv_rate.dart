import 'package:http/src/response.dart';
import 'package:watched_it_2/api/V3/account_states/irate_media.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:http/http.dart' as http;

class TmdbTvRate implements IRateMedia<Tv> {
  @override
  Future<void> rateMedia(
    Tv media, {
    required double rating,
    required String sessionId,
    Future<Response> Function()? dataSource,
  }) async {
    final response = await (dataSource == null ? http.post(
      Uri.parse(urlGenerator(media.id.toString())),
      headers: {},
      body: {},
    ));
    await http.post();
  }
}

extension UrlGenerator on TmdbTvRate {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/recommendations",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
