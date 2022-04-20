import 'package:watched_it_2/models/user/tmdb_user_model.dart';

abstract class AuthenticationProvider {
  Future<TmdbUser> logIn({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<void> initialize();

  TmdbUser? user;
}
