import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

import '../../blocs/api_fetch_bloc/api_fetch_bloc.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
          create: (context) => ApiFetchBloc<PagedResults<Movie>>(
            dataSource: RepositoryProvider.of<INowPlayingMovies>(context)
                .getNowPlayingMovies,
          ),
        ),
        BlocProvider(
          create: (context) => ApiFetchBloc<PagedResults<Movie>>(
            dataSource:
                RepositoryProvider.of<IMoviesPopular>(context).getPopularMovies,
          ),
        ),
      ],
    );
  }
}
