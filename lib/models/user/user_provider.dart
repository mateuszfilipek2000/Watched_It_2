import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/models/user/detailed_user.dart';
import 'package:watched_it_2/models/user/user_model.dart';

@immutable
abstract class UserProvider {
  /// the id argument is for the account you want to retrieve the details of
  Future<DetailedUser> getDetails(String id);

  abstract final User user;
}
