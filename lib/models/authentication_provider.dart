import 'package:watched_it_2/models/user_model.dart';

abstract class AuthenticationProvider {
  Future<User> logIn({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<void> initialize();

  User? user;
}
