import 'package:watched_it_2/models/user/user_model.dart';

class TmdbUser extends User {
  final String accessToken;
  final String sessionId;

  const TmdbUser({
    required String accountId,
    required this.accessToken,
    required this.sessionId,
  }) : super(accountId);
}
