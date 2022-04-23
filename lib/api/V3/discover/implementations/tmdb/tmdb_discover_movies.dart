import 'package:http/http.dart' as http;
import 'package:watched_it_2/api/V3/discover/interfaces/idiscover_movies.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

typedef DataSource = Future<http.Response> Function();

class TmdbDiscoverMovies implements IDiscoverMovies {
  //TODO IMPLEMENT TMDB DISCOVER MOVIES
  const TmdbDiscoverMovies({this.source});

  @override
  Future<List<Movie>> getDiscoverMovies(int page) async {
    final response = await (source == null
        ? http.get(
            Uri.parse(""),
          )
        : source!());

    throw UnimplementedError();
  }

  final DataSource? source;
}
