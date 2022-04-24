import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_credits.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/people/credits_model.dart';

class TmdbMovieCredits implements IMovieCredits {
  const TmdbMovieCredits({this.dataSource});
  @override
  Future<Credits> getMovieCredits(String id) async {
    return await ApiRetrieveObjectImpl<Credits>(
      urlGenerator: () =>
          "https://api.themoviedb.org/3/movie/$id/credits?api_key=$kApiKeyV3&language=en-US",
      jsonConverter: Credits.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }

  final Future<Response> Function()? dataSource;
}
