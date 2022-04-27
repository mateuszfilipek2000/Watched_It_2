import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/account_states/irate_media.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

class TmdbMovieRate implements IRateMedia<Movie> {
  const TmdbMovieRate();
  @override
  Future<void> rateMedia({
    required Movie media,
    required double rating,
    required String sessionId,
    required String url,
    Future<Response> Function()? dataSource,
  }) async {
    rate<Movie>(
      rating: rating,
      url: urlGenerator(
        media.id.toString(),
        sessionId,
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbMovieRate {
  String urlGenerator(String id, String sessionId) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/rating",
        queryParameters: {
          "session_id": sessionId,
        },
      ).toString();
}
