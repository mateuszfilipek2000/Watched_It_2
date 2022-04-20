import 'dart:convert';

import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/user/detailed_user.dart';
import 'package:watched_it_2/models/user/tmdb_user_model.dart';
import 'package:watched_it_2/models/user/user_provider.dart';
import 'package:http/http.dart' as http;

class TmdbUserProvider implements UserProvider {
  const TmdbUserProvider(this.user);

  /// retrieve user details
  @override
  Future<DetailedUser> getDetails(int id) async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/account?api_key=$kApiKeyV3&session_id=${user.sessionId}",
      ),
    );

    if (response.statusCode == 200) {
      return DetailedUser.fromJson(json.decode(response.body));
    }
    // something went wrong with the request,
    // throwing exception with response contents
    throw Exception("${response.statusCode}: ${response.body}");
  }

  /// TmdbUser provides session id and access token necessary to make api calls,
  /// you still need to provide id of a user that you want to retrive
  /// information about
  @override
  final TmdbUser user;
}
