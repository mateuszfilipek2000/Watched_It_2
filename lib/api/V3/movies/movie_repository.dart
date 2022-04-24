import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_latest.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_account_states.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_details.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_top_rated.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_upcoming.dart';

@immutable
abstract class MovieRepository
    implements
        INowPlayingMovies,
        IMovieAccountStates,
        IMovieDetails,
        IPopularMovies,
        IUpcomingMovies,
        ITopRatedMovies,
        ILatestMovies {}
