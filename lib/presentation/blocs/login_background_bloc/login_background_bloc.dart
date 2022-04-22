import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imost_popular_movie_poster.dart';
import 'package:watched_it_2/presentation/blocs/login_background_bloc/login_background_event.dart';
import 'package:watched_it_2/presentation/blocs/login_background_bloc/login_background_state.dart';

class LoginBackgroundBloc
    extends Bloc<LoginBackgroundEvent, LoginBackgroundState> {
  LoginBackgroundBloc({
    required this.topMoviePosterProvider,
  }) : super(const LoginBackgroundInitialState()) {
    on<LoginBackgroundLoadImageEvent>((event, emit) async {
      emit(const LoginBackgroundLoadingState());

      try {
        final imageUrl =
            await topMoviePosterProvider.getMostPopularMoviePosterUrl();
        final bundle = NetworkAssetBundle(Uri.parse(imageUrl));
        final image = (await bundle.load(imageUrl)).buffer.asUint8List();
        emit(LoginBackgroundLoadingSuccessState(image));
      } catch (e) {
        log(e.toString());
        emit(LoginBackgroundLoadingFailureState(e));
      }
    });
  }

  final IMostPopularMoviePoster topMoviePosterProvider;
}
