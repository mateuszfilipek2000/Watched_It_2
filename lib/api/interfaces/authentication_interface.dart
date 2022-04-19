import 'package:watched_it_2/models/people/user_model.dart';

abstract class AuthenticationInterface {
  Future<User> authenticate();
}
