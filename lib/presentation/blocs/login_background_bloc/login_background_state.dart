import 'dart:typed_data';

import 'package:flutter/foundation.dart';

@immutable
abstract class LoginBackgroundState {
  const LoginBackgroundState();
}

class LoginBackgroundInitialState extends LoginBackgroundState {
  const LoginBackgroundInitialState();
}

class LoginBackgroundLoadingState extends LoginBackgroundState {
  const LoginBackgroundLoadingState();
}

class LoginBackgroundLoadingSuccessState extends LoginBackgroundState {
  const LoginBackgroundLoadingSuccessState(this.image);

  final Uint8List image;
}

class LoginBackgroundLoadingFailureState extends LoginBackgroundState {
  const LoginBackgroundLoadingFailureState(this.exception);

  final Object exception;
}
