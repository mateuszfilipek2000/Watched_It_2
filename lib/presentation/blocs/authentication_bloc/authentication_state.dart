import 'package:watched_it_2/models/user_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationStateLoading extends AuthenticationState {
  const AuthenticationStateLoading();
}

class AuthenticationStateLoggedIn extends AuthenticationState {
  const AuthenticationStateLoggedIn({
    required this.user,
  });

  final User user;
}

class AuthenticationStateLoginFailure extends AuthenticationState {
  const AuthenticationStateLoginFailure(this.exception);

  final Object exception;
}

class AuthenticationStateLoggedOut extends AuthenticationState {
  const AuthenticationStateLoggedOut();
}

class AuthenticationStateLogoutFailure extends AuthenticationState {
  const AuthenticationStateLogoutFailure(this.exception);

  final Object exception;
}
