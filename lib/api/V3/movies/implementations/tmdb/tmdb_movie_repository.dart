import 'package:http/src/response.dart';
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
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_repository.dart'
    hide UrlGenerator;
import 'package:watched_it_2/models/account_states_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/movie/detailed_movie_model.dart';
import 'package:watched_it_2/models/list_element_model.dart';
import 'package:watched_it_2/models/keyword_model.dart';
import 'package:watched_it_2/models/justwatch_watch_providers.dart';
import 'package:watched_it_2/models/image_model.dart';
import 'package:watched_it_2/models/people/credits_model.dart';
import 'package:watched_it_2/models/review_model.dart';

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
  @override
  Future<AccountStates> getAccountStates(String id,
      {Future<Response> Function()? dataSource}) {
    // TODO: implement getAccountStates
    throw UnimplementedError();
  }

  @override
  Future<Credits> getMovieCredits(String id,
      {Future<Response> Function()? dataSource}) {
    // TODO: implement getMovieCredits
    throw UnimplementedError();
  }

  @override
  Future<DetailedMovie> getMovieDetails(String id,
      {Future<Response> Function()? dataSource}) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }

  @override
  Future<Images> getMovieImages(String id,
      {Future<Response> Function()? dataSource}) {
    // TODO: implement getMovieImages
    throw UnimplementedError();
  }

  @override
  Future<Keywords> getMovieKeywords(String id,
      {Future<Response> Function()? dataSource}) {
    // TODO: implement getMovieKeywords
    throw UnimplementedError();
  }

  @override
  Future<ListModel> getMovieLists(
      {required String id,
      int page = 1,
      Future<Response> Function()? dataSource}) {
    // TODO: implement getMovieLists
    throw UnimplementedError();
  }

  @override
  Future<PagedResults<Review>> getMovieReviews(
      {int page = 1,
      required String id,
      Future<Response> Function()? dataSource}) {
    // TODO: implement getMovieReviews
    throw UnimplementedError();
  }

  @override
  Future<JustWatchWatchProviders> getMovieWatchProviders(String id,
      {Future<Response> Function()? dataSource}) {
    // TODO: implement getMovieWatchProviders
    throw UnimplementedError();
  }

  @override
  Future<PagedResults<Movie>> getNowPlayingMovies(
      {int page = 1, Future<Response> Function()? dataSource}) {
    // TODO: implement getNowPlayingMovies
    throw UnimplementedError();
  }

  @override
  Future<PagedResults<Movie>> getPopularMovies(
      {int page = 1, Future<Response> Function()? dataSource}) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<PagedResults<Movie>> getRecommendations(
      {required String id,
      int page = 1,
      Future<Response> Function()? dataSource}) {
    // TODO: implement getRecommendations
    throw UnimplementedError();
  }

  @override
  Future<PagedResults<Movie>> getSimilarMovies(
      {required String id,
      int page = 1,
      Future<Response> Function()? dataSource}) {
    // TODO: implement getSimilarMovies
    throw UnimplementedError();
  }

  @override
  Future<PagedResults<Movie>> getTopRatedMovies(
      {int page = 1, Future<Response> Function()? dataSource}) {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<PagedResults<Movie>> getUpcomingMovies(
      {int page = 1, Future<Response> Function()? dataSource}) {
    // TODO: implement getUpcomingMovies
    throw UnimplementedError();
  }
}
