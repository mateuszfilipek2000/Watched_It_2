import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_now_playing.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_popular.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovies_upcoming.dart';
import 'package:watched_it_2/api/interfaces/iimage_url_provider.dart';
import 'package:watched_it_2/models/idisplayable.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';
import 'package:watched_it_2/presentation/blocs/api_fetch_bloc/api_fetch_state.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/components/displayable_item_list/displayable_item_list.dart';
import 'package:watched_it_2/presentation/shared_widgets/menu_list.dart';

import '../../blocs/api_fetch_bloc/api_fetch_bloc.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  // horizontal: 8.0,
                  vertical: 20.0,
                ),
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: <TextSpan>[
                        const TextSpan(text: "Watched "),
                        TextSpan(
                          text: "It ",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: "2"),
                      ]),
                ),
              ),
              const Expanded(
                child: MenuList(
                  sections: [
                    MenuSection(
                      items: [
                        MenuListItem(
                          index: 0,
                          title: Text("Movies"),
                          icon: Icon(
                            Icons.movie,
                          ),
                        ),
                        MenuListItem(
                          index: 1,
                          title: Text("Tv series"),
                          icon: Icon(
                            Icons.movie,
                          ),
                        ),
                      ],
                      title: Text("Media"),
                    ),
                    MenuSection(
                      items: [
                        MenuListItem(
                          index: 2,
                          title: Text("My account"),
                          icon: Icon(
                            Icons.account_circle_outlined,
                          ),
                        ),
                        MenuListItem(
                          index: 3,
                          title: Text("My lists"),
                          icon: Icon(
                            Icons.list,
                          ),
                        ),
                      ],
                      title: Text("User"),
                    ),
                    MenuSection(
                      items: [
                        MenuListItem(
                          index: 4,
                          title: Text("Settings"),
                          icon: Icon(
                            Icons.settings,
                          ),
                        ),
                      ],
                      title: Text("General"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(
          // height: double.infinity,
          thickness: 1.5,
          // indent: 8.0,
          // endIndent: 8.0,
          // color: Colors.blue,
        ),
        Expanded(
          flex: 85,
          child: Column(
            children: [
              Row(
                children: const [
                  Text("Asd"),
                  Text("Asd"),
                  Text("Asd"),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocProvider(
                        create: (context) => ApiFetchBloc<PagedResults<Movie>>(
                          dataSource:
                              RepositoryProvider.of<IMoviesUpcoming>(context)
                                  .getUpcomingMovies,
                        ),
                        lazy: false,
                        child: const MediaList<Movie, PagedResults<Movie>>(
                          listName: "Upcoming Movies",
                        ),
                      ),
                      BlocProvider(
                        create: (context) => ApiFetchBloc<PagedResults<Movie>>(
                          dataSource:
                              RepositoryProvider.of<INowPlayingMovies>(context)
                                  .getNowPlayingMovies,
                        ),
                        lazy: false,
                        child: const MediaList<Movie, PagedResults<Movie>>(
                          listName: "Now playing movies",
                        ),
                      ),
                      BlocProvider(
                        create: (context) => ApiFetchBloc<PagedResults<Movie>>(
                          dataSource:
                              RepositoryProvider.of<IMoviesPopular>(context)
                                  .getPopularMovies,
                        ),
                        lazy: false,
                        child: const MediaList<Movie, PagedResults<Movie>>(
                          listName: "Popular Movies",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MediaList<V extends IDisplayable, T extends PagedResults<V>>
    extends StatelessWidget {
  const MediaList({
    Key? key,
    required this.listName,
  }) : super(key: key);

  final String listName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(
            height: 5.0,
          ),
          const SizedBox(
            height: 5.0,
          ),
          BlocBuilder<ApiFetchBloc<T>, ApiFetchState<T>>(
            bloc: RepositoryProvider.of<ApiFetchBloc<T>>(context),
            builder: (context, state) {
              if (state is ApiFetchLoading<T>) {
                return const CircularProgressIndicator();
              }
              if (state is ApiFetchSuccess<T>) {
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
              return Center(child: Text("Couldn't load $listName"));
            },
          ),
        ],
      ),
    );
  }
}
