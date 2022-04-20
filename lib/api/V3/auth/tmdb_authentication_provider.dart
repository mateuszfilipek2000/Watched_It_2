import 'dart:developer';

import 'package:watched_it_2/models/authentication_provider.dart';
import 'package:watched_it_2/models/user/tmdb_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:watched_it_2/models/user/tmdb_user_provider.dart';

class TmdbAuthenticationProvider implements AuthenticationProvider {
  @override
  TmdbUser? user;

  @override
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetails = prefs.getString('user');
    if (userDetails != null) {
      try {
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

          // there's no need to save this result, just checking if it completes
          // without throwing any errors
          // TODO THAT COULD BE A GOOD PLACE TO RETRIEVE SOME CONFIG INFO AS WELL
          final _user = TmdbUser(
            accessToken: accessToken,
            accountId: accountId,
            sessionId: sessionId,
          );
          await TmdbUserProvider(_user).getDetails(accountId);
          // user is valid, saving
          user = _user;
        }
      } catch (e) {
        log(e.toString());
        log("Something went wrong while initializing, user is not saved");
      }
    }
  }

  @override
  Future<TmdbUser> logIn({required String username, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
