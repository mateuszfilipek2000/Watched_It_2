import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/configuration/implementations/tmdb_api_configuration.dart';
import 'package:watched_it_2/api/V3/configuration/interfaces/iapi_configuration.dart';
import 'package:watched_it_2/api/V3/movies/tmdb_implementations/tmdb_most_popular_movie_poster.dart';
import 'package:watched_it_2/api/interfaces/tmdb_image_url.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_events.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_state.dart';
import 'package:watched_it_2/presentation/blocs/login_background_bloc/login_background_bloc.dart';
import 'package:watched_it_2/presentation/blocs/login_background_bloc/login_background_event.dart';
import 'package:watched_it_2/presentation/blocs/login_background_bloc/login_background_state.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/dashboard_screen.dart';

/*
  All devices share the same login screen ui
*/
class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundOpacityAnimationController;
  late Animation<double> _backgroundOpacityAnimation;

  @override
  void initState() {
    // instantiating controllers

    _backgroundOpacityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
    );

    // background animation is controlling background opacity animation
    _backgroundOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundOpacityAnimationController,
        curve: Curves.easeIn,
      ),
    );
    //background position animation is responsible for a simple 'parallax' effect

    //TODO CREATE BACKGROUND POSITION ANIMATION

    super.initState();
  }

  @override
  void dispose() {
    _backgroundOpacityAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: context.read<AuthenticationBloc>()
          ..add(const AuthenticationEventInitialize()),
        listener: (context, state) {
          // if (state is AuthenticationStateInitial) {
          //   context.read<AuthenticationBloc>().add(
          //         const AuthenticationEventInitialize(),
          //       );
          // } else
          if (state is AuthenticationStateLoggedIn) {
            Navigator.pushNamed(context, DashboardScreen.routeName);
          } else if (state is AuthenticationStateLoginFailure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(state.exception.toString()),
                  actions: [
                    TextButton(
                      child: const Text("Ok"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            );
          } else if (state is AuthenticationStateWaitingForConfirmation) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                      "Tap the ok button after you've approved of request token!"),
                  actions: [
                    TextButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(const AuthenticationEventConfirmDialog());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              BlocProvider(
                create: (context) => LoginBackgroundBloc(
                  topMoviePosterProvider: const TmdbMostPopularMoviePoster(),
                  imageUrlProvider: TmdbImageUrlProvider(
                    // IApiConfiguration implements image configuration provider
                    imageConfigurationProvider:
                        RepositoryProvider.of<TmdbApiConfiguration>(context),
                  ),
                )..add(const LoginBackgroundLoadImageEvent()),
                child: BlocConsumer<LoginBackgroundBloc, LoginBackgroundState>(
                  listener: (context, state) {
                    if (state is LoginBackgroundLoadingSuccessState) {
                      _backgroundOpacityAnimationController.forward();
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginBackgroundLoadingSuccessState) {
                      return AnimatedBuilder(
                          animation: _backgroundOpacityAnimation,
                          child: Image.memory(
                            state.image,
                            fit: BoxFit.cover,
                          ),
                          builder: (context, child) {
                            return Opacity(
                              opacity: _backgroundOpacityAnimation.value,
                              child: child,
                            );
                          });
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              Center(
                child: TextButton(
                  child: const Text("Log in"),
                  onPressed: () => context.read<AuthenticationBloc>().add(
                        const AuthenticationEventLogIn(
                          username: "",
                          password: "",
                        ),
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
