import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class User {
  const User(this.accountId);
  final String accountId;
}
