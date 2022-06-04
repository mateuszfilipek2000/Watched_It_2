import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/configuration/interfaces/iapi_configuration.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_repository.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/api/interfaces/iimage_url_provider.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/presentation/blocs/api_fetch_bloc/api_fetch_state.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/components/displayable_item_list/displayable_item_list.dart';

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
          lazy: false,
          child: BlocBuilder<ApiFetchBloc<PagedResults<Movie>>,
              ApiFetchState<PagedResults<Movie>>>(
            bloc: ApiFetchBloc<PagedResults<Movie>>(
              dataSource: RepositoryProvider.of<INowPlayingMovies>(context)
                  .getNowPlayingMovies,
            ),
            builder: (context, state) {
              if (state is ApiFetchLoading<PagedResults<Movie>>) {
                return const CircularProgressIndicator();
              }
              if (state is ApiFetchSuccess<PagedResults<Movie>>) {
                return SizedBox(
                  height: 200.0,
                  child: DisplayableItemList(
                    items: state.resource.results,
                    imageUrlGenerator: (String partialUrl) =>
                        RepositoryProvider.of<IImageUrlProvider>(context)
                            .getFullImageUrl(
                      url: partialUrl,
                      imageType: ImageType.poster,
                      size: 40,
                    ),
                    onTap: (int i) => log('Tapped $i'),
                  ),
                );
              }
              return const Text("asd");
            },
          ),
        ),
        BlocProvider(
          create: (context) => ApiFetchBloc<PagedResults<Movie>>(
            dataSource:
                RepositoryProvider.of<IMoviesPopular>(context).getPopularMovies,
          ),
          lazy: false,
          child: Builder(builder: (context) {
            return Text(
              context
                  .read<ApiFetchBloc<PagedResults<Movie>>>()
                  .runtimeType
                  .toString(),
            );
          }),
        ),
      ],
    );
  }
}
