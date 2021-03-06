import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_repository.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_popular.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movies_upcoming.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_repository.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_upcoming.dart';
import 'package:watched_it_2/presentation/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/dashboard_screen.dart';

/// [LoggedInScreen] is the top route for logged in users
///
/// it is used to provide access to all repositories that logged in user
/// might make use of, such as [TmdbMovieRepository]
///
/// after creating all repository providers the user is redirected to [DashboardScreen]
///
/// you shouldn't use this route directly, it is only to be used as the very
/// top node in widget tree
class LoggedInScreen extends StatelessWidget {
  static const String routeName = "LoggedInScreen";
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider(
        //   create: (context) => TmdbMovieRepository() as IMovieRepository,
        //   lazy: false,
        // ),
        RepositoryProvider(
          create: (context) => TmdbMoviesNowPlaying() as INowPlayingMovies,
        ),
        RepositoryProvider(
          create: (context) => TmdbMoviesPopular() as IMoviesPopular,
        ),
        RepositoryProvider(
          create: (context) => TmdbMoviesUpcoming() as IMoviesUpcoming,
        ),
        // RepositoryProvider(
        //   create: (context) => SubjectRepository(),
        // ),
      ],
      child: BlocProvider(
        create: (context) => NavigationCubit(),
        child: const DashboardScreen(),
      ),
    );
  }
}
