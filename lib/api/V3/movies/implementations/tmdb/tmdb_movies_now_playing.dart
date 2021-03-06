import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

class TmdbMoviesNowPlaying implements INowPlayingMovies {
  // const TmdbMoviesNowPlaying();
  @override
  Future<PagedResults<Movie>> getNowPlayingMovies({
    // int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    if (pagedResults != null) {
      return pagedResults!;
    }
    pagedResults = await ApiRetrieveObject.retrieveObject<PagedResults<Movie>>(
      urlGenerator: () => urlGenerator(1),
      jsonConverter: (json) => pagedResultsFromJson<Movie>(
        json,
        Movie.fromJson,
        urlGenerator,
      ),
      dataSource: dataSource,
    );

    return pagedResults!;
  }

  //TODO ADD CACHING LIKE THIS TO ALL SIMILAR CLASSES
  PagedResults<Movie>? pagedResults;
}

extension UrlGenerator on TmdbMoviesNowPlaying {
  String urlGenerator(int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/now_playing",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
