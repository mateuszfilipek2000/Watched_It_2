import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/authentication_provider.dart';
import 'package:watched_it_2/models/user/tmdb_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:watched_it_2/models/user/tmdb_user_provider.dart';
import 'package:http/http.dart' as http;

class TmdbAuthenticationRepository implements AuthenticationRepository {
  @override
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    log("initializing authentication");
    try {
      final accessToken = prefs.getString('accessToken');
      final accountId = prefs.getString('accountId');
      final sessionId = prefs.getString('sessionId');

      // checking if user data exists in shared preferences
      if (accessToken != null && accountId != null && sessionId != null) {
        log("user credentials are saved");
        // checking if saved user data is valid
        final _user = TmdbUser(
          accessToken: accessToken,
          accountId: accountId,
          sessionId: sessionId,
        );
        // tmdb api doesnt offer a way to check if session id is still valid
        // simple request is made to retrieve account details to check if
        // credentials are still active

        // there's no need to save this result, just checking if it completes
        // without throwing any errors
        await TmdbUserProvider(_user).getDetails(accountId);
        log("succesfully made a request to confirm user details are vaild");
        // user is valid, saving
        user = _user;
      }
    } catch (e) {
      log(e.toString());
      log("Something went wrong while initializing, user is not saved");
    }
  }

  /// this function assumes that user has succesfully approved of request token,
  /// if user would not approve of it, or something should go wrong with connection
  /// an exception will be thrown
  @override
  Future<TmdbUser> logIn(
      {required String username, required String password}) async {
    if (requestToken != null && requestTokenGenerationTime != null) {
      // checking if the generated request token is valid
      if (requestTokenGenerationTime!.difference(DateTime.now()).inMinutes <
          15) {
        // request token is not null, and was generated less then 15 minutes ago
        // generating access token
        final accessTokenResponse = await http.post(
          Uri.parse("https://api.themoviedb.org/4/auth/access_token"),
          headers: {
            "content-type": "application/json;charset=utf-8",
            "authorization": "Bearer $kApiReadAccessTokenV4"
          },
          body: json.encode(
            {"request_token": requestToken},
          ),
        );
        if (accessTokenResponse.statusCode == 200) {
          // access token is succesfully generated
          final response = json.decode(accessTokenResponse.body);
          final accountId = response["account_id"];
          final accessToken = response["access_token"];

          // with access token generated the session id is generated
          final sessionIdResponse = await http.post(
            Uri.parse(
                "https://api.themoviedb.org/3/authentication/session/convert/4?api_key=$kApiKeyV3"),
            headers: {
              "content-type": "application/json;charset=utf-8",
              "authorization": "Bearer $kApiReadAccessTokenV4"
            },
            body: json.encode(
              {"access_token": accessToken},
            ),
          );
          if (sessionIdResponse.statusCode == 200) {
            // session id is created succesfully, user can be generated
            final sessionId = json.decode(sessionIdResponse.body)["session_id"];

            // saving user data into the local storage
            final prefs = await SharedPreferences.getInstance();
            prefs.setString("accessToken", accessToken);
            prefs.setString("accountId", accountId);
            prefs.setString("sessionId", sessionId);

            return TmdbUser(
              accountId: accountId,
              accessToken: accessToken,
              sessionId: sessionId,
            );
          }
          log("access token generated succesfully, couldn't create session id from it");
          log("${sessionIdResponse.statusCode}: ${sessionIdResponse.body}");
          throw Exception(
              "access token generated succesfully, couldn't create session id from it");
        }
        log("Couldn't generate access token");
        log("${accessTokenResponse.statusCode}: ${accessTokenResponse.body}");
        throw Exception("Couldn't generate access token");
      } else {
        throw Exception("Request token is invalid");
      }
    } else {
      log("request token: $requestToken, request token generation time: $requestTokenGenerationTime");
      throw Exception(
          "You need to generate request token before requesting to log in");
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  /// TMDB doesn't actually let us log users in using their login credentials
  /// so username and user password will not be used
  /// this function needs to be called before calling login function
  /// user needs to approve of request token before they can be logged in
  Future<void> generateRequestToken() async {
    // checking if there's already a generated request token
    if (requestToken != null && requestTokenGenerationTime != null) {
      // checking if the generated request token is valid
      if (requestTokenGenerationTime!.difference(DateTime.now()).inMinutes <
          15) {
        return;
      }
    }
    // if there's no valid request token generated, a new one is created
    final response = await http.post(
      Uri.parse("https://api.themoviedb.org/4/auth/request_token"),
      headers: {
        "content-type": "application/json;charset=utf-8",
        "authorization": "Bearer $kApiReadAccessTokenV4"
      },
    );

    if (response.statusCode == 200) {
      // request token generated succesfully, creating access
      final requestToken = json.decode(response.body)["request_token"];

      // saving generated token to class variable, it'll be used to generate
      // access token, request token generation time is also saved, because
      // every request token is valid for 15 minutes
      this.requestToken = requestToken;
      requestTokenGenerationTime = DateTime.now();

      // with the request token generated the url launcher takes user to
      // tmdb page in order to accept it
      launch(
          "https://www.themoviedb.org/auth/access?request_token=$requestToken");
    } else {
      log("Problem with creating request token");
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }

  @override
  TmdbUser? user;

  /// request token needs to be generated before logging user in
  /// request tokens are valid for 15 minutes
  String? requestToken;

  DateTime? requestTokenGenerationTime;
}
