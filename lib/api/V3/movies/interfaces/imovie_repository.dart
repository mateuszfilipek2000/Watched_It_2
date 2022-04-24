import 'package:watched_it_2/api/V3/movies/interfaces/imovie_account_states.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_credits.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_details.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_images.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_keywords.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_lists.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_recommendations.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_reviews.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_similar.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_watch_providers.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_top_rated.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_upcoming.dart';

abstract class IMovieRepository
    implements
        IMovieDetails,
        IMovieAccountStates,
        IMovieCredits,
        IMovieImages,
        IMovieKeywords,
        IMovieLists,
        IMovieRecommentations,
        IMovieReviews,
        IMovieSimilar,
        IMovieWatchProviders,
        INowPlayingMovies,
        IMoviesPopular,
        IMoviesTopRated,
        IMoviesUpcoming {}
