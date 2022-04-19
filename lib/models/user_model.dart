import 'package:flutter/foundation.dart' show immutable;

@immutable
class User {
  final String accessToken;
  final String accountId;
  final String sessionId;

  const User({
    required this.accessToken,
    required this.accountId,
    required this.sessionId,
  });
}
