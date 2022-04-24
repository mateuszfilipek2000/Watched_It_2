import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_keywords.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/keyword_model.dart';

class TmdbMovieKeywords implements IMovieKeywords {
  const TmdbMovieKeywords({this.dataSource});

  @override
  Future<Keywords> getMovieKeywords(String id) async {
    return await ApiRetrieveObjectImpl<Keywords>(
      urlGenerator: () =>
          "https://api.themoviedb.org/3/movie/$id/keywords?api_key=$kApiKeyV3",
      jsonConverter: Keywords.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }

  final Future<Response> Function()? dataSource;
}
