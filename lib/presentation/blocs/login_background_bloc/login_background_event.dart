import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LoginBackgroundEvent {
  const LoginBackgroundEvent();
}

class LoginBackgroundLoadImageEvent extends LoginBackgroundEvent {
  const LoginBackgroundLoadImageEvent();
}
