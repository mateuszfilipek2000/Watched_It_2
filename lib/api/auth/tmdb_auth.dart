import 'package:http/http.dart' as http;
import 'package:watched_it_2/api/interfaces/authentication_interface.dart';
import 'package:watched_it_2/models/user_model.dart';

class TmdbAuthentication implements AuthenticationInterface {
  @override
  Future<User> authenticate() async {
    /*
    generate request token -> generate access token -> get session_id from access token
    */
    // TODO: implement authenticate
    throw UnimplementedError();
  }
}
