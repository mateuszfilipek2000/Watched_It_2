import 'package:watched_it_2/models/authentication_provider.dart';
import 'package:watched_it_2/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TmdbAuthenticationProvider implements AuthenticationProvider {
  @override
  User? user;

  @override
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetails = prefs.getString('user');
    if (userDetails != null) {
      final userJson = json.decode(userDetails);
      final accessToken = userJson['accessToken'];
      final accountId = userJson['accountId'];
      final sessionId = userJson['sessionId'];
      // checking if user data exists in shared preferences
      if (accessToken != null && accountId != null && sessionId != null) {
        // checking if saved user data is valid
        // tmdb api doesnt offer a way to check if session id is still valid
        // simple request is made to retrieve account details to check if
        // credentials are still active
        // TODO ADD REQUEST TO CHECK IF CREDENTIALS ARE VALID

        // user is valid, saving
        user = User(
          accessToken: accessToken,
          accountId: accountId,
          sessionId: sessionId,
        );
      }
    }
  }

  @override
  Future<User> logIn({required String username, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
