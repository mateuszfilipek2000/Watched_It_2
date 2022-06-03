import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/tmdb_movie_repository.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_repository.dart';
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
        RepositoryProvider(
          create: (context) => TmdbMovieRepository as IMovieRepository,
        ),
        // RepositoryProvider(
        //   create: (context) => SubjectRepository(),
        // ),
      ],
      child: const DashboardScreen(),
    );
  }
}
