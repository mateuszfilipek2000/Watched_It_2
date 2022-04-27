import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/account_states/irate_media.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/episode_model.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';

class TmdbTvEpisodeRate implements IRateMedia<Episode> {
  @override
  Future<void> rateMedia({
    required Episode media,
    required double rating,
    required String sessionId,
    required String url,
    Future<Response> Function()? dataSource,
  }) async {
    rate<Episode>(
      rating: rating,
      url: urlGenerator(
        media.id.toString(),
        sessionId,
      ),
      dataSource: dataSource,
    );
  }
}

//TODO THINK OF A WAY TO PASS SEASON ID WITHOUT CHANGING MUCH
extension UrlGenerator on TmdbTvEpisodeRate {
  String urlGenerator(String id, String sessionId) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/episode",
        queryParameters: {
          "page": id.toString(),
          "session_id": sessionId,
        },
      ).toString();
}
