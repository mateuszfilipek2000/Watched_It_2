import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/account_states/irate_media.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';

class TmdbTvRate implements IRateMedia<Tv> {
  @override
  Future<void> rateMedia({
    required Tv media,
    required double rating,
    required String sessionId,
    required String url,
    Map<String, String>? optionalParameters,
    Future<Response> Function()? dataSource,
  }) async {
    await rate<Tv>(
      rating: rating,
      url: urlGenerator(
        media.id.toString(),
        sessionId,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvRate {
  String urlGenerator(String id, String sessionId) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/rating",
        queryParameters: {
          "session_id": sessionId,
        },
      ).toString();
}
