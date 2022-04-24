import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_account_states.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_credits.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_details.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_images.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_keywords.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_lists.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_recommendations.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_reviews.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_similar.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_watch_providers.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_now_playing.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_popular.dart'
    hide UrlGenerator;
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_top_rated.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_upcoming.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_repository.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';

//TODO ADD CACHING, ADD RETRIEVING DATA USING APPEND TO RESPONSE
class TmdbMovieRepository
    with
        TmdbMovieAccountStates,
        TmdbMovieCredits,
        TmdbMovieDetails,
        TmdbMovieImages,
        TmdbMovieKeywords,
        TmdbMovieLists,
        TmdbMovieReviews,
        TmdbMovieWatchProviders,
        TmdbMoviesNowPlaying,
        TmdbMoviesPopular,
        TmdbMovieRecommendations,
        TmdbMovieSimilar,
        TmdbMoviesTopRated,
        TmdbMoviesUpcoming
    implements IMovieRepository {
  // THESE FOUR LISTS WILL BE CACHED
  final List<PagedResults<Movie>> nowPlayingMovies = [];
  final List<PagedResults<Movie>> popularMovies = [];
  final List<PagedResults<Movie>> topRatedMovies = [];
  final List<PagedResults<Movie>> upcomingMovies = [];

  @override
  Future<PagedResults<Movie>> getNowPlayingMovies(
      {int page = 1, Future<Response> Function()? dataSource}) async {
    if (page - 1 < 0) {
      throw Exception(
          "Page number can't be lower than 1, you've asked for page number $page");
    }

    if (page - 1 <= nowPlayingMovies.length) {
      //retrieving from cache
      return nowPlayingMovies[page - 1];
    } else {
      // asked for element that's not in cache, retrieving from api
      final newPage = await super.getNowPlayingMovies(page: page + 1);
      nowPlayingMovies.add(newPage);
      return newPage;
    }
  }

  @override
  Future<PagedResults<Movie>> getPopularMovies(
      {int page = 1, Future<Response> Function()? dataSource}) async {
    if (page - 1 < 0) {
      throw Exception(
          "Page number can't be lower than 1, you've asked for page number $page");
    }

    if (page - 1 <= popularMovies.length) {
      //retrieving from cache
      return popularMovies[page - 1];
    } else {
      // asked for element that's not in cache, retrieving from api
      final newPage = await super.getPopularMovies(page: page + 1);
      popularMovies.add(newPage);
      return newPage;
    }
  }

  @override
  Future<PagedResults<Movie>> getTopRatedMovies(
      {int page = 1, Future<Response> Function()? dataSource}) async {
    if (page - 1 < 0) {
      throw Exception(
          "Page number can't be lower than 1, you've asked for page number $page");
    }

    if (page - 1 <= topRatedMovies.length) {
      //retrieving from cache
      return topRatedMovies[page - 1];
    } else {
      // asked for element that's not in cache, retrieving from api
      final newPage = await super.getTopRatedMovies(page: page + 1);
      topRatedMovies.add(newPage);
      return newPage;
    }
  }

  @override
  Future<PagedResults<Movie>> getUpcomingMovies(
      {int page = 1, Future<Response> Function()? dataSource}) async {
    if (page - 1 < 0) {
      throw Exception(
          "Page number can't be lower than 1, you've asked for page number $page");
    }

    if (page - 1 <= upcomingMovies.length) {
      //retrieving from cache
      return upcomingMovies[page - 1];
    } else {
      // asked for element that's not in cache, retrieving from api
      final newPage = await super.getUpcomingMovies(page: page + 1);
      upcomingMovies.add(newPage);
      return newPage;
    }
  }
}
