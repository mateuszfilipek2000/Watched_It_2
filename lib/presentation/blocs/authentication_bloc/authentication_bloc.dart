import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/api/V3/auth/tmdb_authentication_repository.dart';
import 'package:watched_it_2/models/authentication_provider.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_events.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.authenticationProvider)
      : super(const AuthenticationStateInitial()) {
    on<AuthenticationEventInitialize>((event, emit) async {
      await authenticationProvider.initialize();
      final user = authenticationProvider.user;
      // if after initialization user is null then login credentials need to be provided
      if (user == null) {
        emit(const AuthenticationStateLoggedOut());
      } else {
        // user is succesfully logged in
        emit(AuthenticationStateLoggedIn(user: user));
      }
    });
    on<AuthenticationEventLogIn>((event, emit) async {
      emit(const AuthenticationStateLoading());

      // tmdb need to have generated a request token before logging in
      if (authenticationProvider is TmdbAuthenticationRepository) {
        try {
          await (authenticationProvider as TmdbAuthenticationRepository)
              .generateRequestToken();
          // user is redirected to tmdb page in order to approve of request token
          emit(const AuthenticationStateWaitingForConfirmation());
        } catch (e) {
          emit(AuthenticationStateLoginFailure(e));
        }
      } else {
        // this code isn't really used now, but I'm leaving it as is, because
        // I'll probably add my own server to try some things
        try {
          final user = await authenticationProvider.logIn(
            username: event.username,
            password: event.password,
          );

          emit(AuthenticationStateLoggedIn(user: user));
        } catch (e) {
          emit(AuthenticationStateLoginFailure(e));
        }
      }
    });
    on<AuthenticationEventConfirmDialog>((event, emit) async {
      try {
        // this event is used only with tmdb authentication provider, tmdb
        // doesnt require username and password to log in, leaving it blank
        final user =
            await authenticationProvider.logIn(username: "", password: "");
        emit(AuthenticationStateLoggedIn(user: user));
      } catch (e) {
        emit(AuthenticationStateLoginFailure(e));
      }
    });
    on<AuthenticationEventLogOut>((event, emit) async {
      emit(const AuthenticationStateLoading());
      try {
        await authenticationProvider.logout();
        emit(const AuthenticationStateLoggedOut());
      } catch (e) {
        emit(AuthenticationStateLogoutFailure(e));
      }
    });
  }

  final AuthenticationRepository authenticationProvider;
}
