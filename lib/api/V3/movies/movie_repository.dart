import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/api/V3/movies/interfaces/ialternative_titles.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/ilatest_movies.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_account_states.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_details.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/inow_playing_movies.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/ipopular_movies.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/itop_rated_movies.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/iupcoming_movies.dart';

@immutable
abstract class MovieRepository
    implements
        INowPlayingMovies,
        IMovieAccountStates,
        IAlternativeTitles,
        IMovieDetails,
        IPopularMovies,
        IUpcomingMovies,
        ITopRatedMovies,
        ILatestMovies {}
