import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imost_popular_movie_poster.dart';
import 'package:watched_it_2/api/interfaces/iimage_url_provider.dart';
import 'package:watched_it_2/presentation/blocs/login_background_bloc/login_background_event.dart';
import 'package:watched_it_2/presentation/blocs/login_background_bloc/login_background_state.dart';

class LoginBackgroundBloc
    extends Bloc<LoginBackgroundEvent, LoginBackgroundState> {
  LoginBackgroundBloc({
    required this.topMoviePosterProvider,
    required this.imageUrlProvider,
    required this.imageType,
  }) : super(const LoginBackgroundInitialState()) {
    on<LoginBackgroundLoadImageEvent>((event, emit) async {
      emit(const LoginBackgroundLoadingState());

      try {
        final partialImageUrl =
            await topMoviePosterProvider.getMostPopularMovieImageUrl(
          imageType: imageType,
        );
        final imageUrl = await imageUrlProvider.getFullImageUrl(
          url: partialImageUrl,
          imageType: imageType,
          size: 60,
        );
        final bundle = NetworkAssetBundle(Uri.parse(imageUrl));
        final image = (await bundle.load(imageUrl)).buffer.asUint8List();
        emit(LoginBackgroundLoadingSuccessState(image));
      } catch (e) {
        log(e.toString());
        emit(LoginBackgroundLoadingFailureState(e));
      }
    });
  }

  final IMostPopularMovieImage topMoviePosterProvider;
  final IImageUrlProvider imageUrlProvider;
  final ImageType imageType;
}
