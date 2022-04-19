import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEventInitialize extends AuthenticationEvent {
  const AuthenticationEventInitialize();
}

class AuthenticationEventLogIn extends AuthenticationEvent {
  const AuthenticationEventLogIn({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class AuthenticationEventLogOut extends AuthenticationEvent {
  const AuthenticationEventLogOut();
}
