import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/models/authentication_provider.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_events.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.authenticationProvider)
      : super(const AuthenticationStateLoading()) {
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
      try {
        final user = await authenticationProvider.logIn(
          username: event.username,
          password: event.password,
        );

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

  final AuthenticationProvider authenticationProvider;
}
