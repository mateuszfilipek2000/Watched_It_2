import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/account_states/irate_media.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/episode_model.dart';

class TmdbTvEpisodeRate implements IRateMedia<Episode> {
  /// when rating tv episode remember to pass season number
  /// and episode number as optional parameters, function will fail
  /// if they're omitted
  @override
  Future<void> rateMedia({
    required Episode media,
    required double rating,
    required String sessionId,
    required String url,
    Map<String, String>? optionalParameters,
    Future<Response> Function()? dataSource,
  }) async {
    assert(optionalParameters != null);
    assert(optionalParameters!.isNotEmpty);
    assert(optionalParameters!["season_number"] != null);
    assert(optionalParameters!["episode_number"] != null);

    final String seasonNumber = optionalParameters!["season_number"]!;
    final String episodeNumber = optionalParameters["episode_number"]!;

    await rate<Episode>(
      rating: rating,
      url: urlGenerator(
        id: media.id.toString(),
        sessionId: sessionId,
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbTvEpisodeRate {
  String urlGenerator({
    required String id,
    required String sessionId,
    required String seasonNumber,
    required String episodeNumber,
  }) =>
      TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/season/$seasonNumber/episode/$episodeNumber/rating",
        queryParameters: {
          "page": id.toString(),
          "session_id": sessionId,
        },
      ).toString();
}
