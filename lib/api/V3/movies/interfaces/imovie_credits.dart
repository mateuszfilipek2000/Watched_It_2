import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/models/people/credits_model.dart';

@immutable
abstract class IMovieCredits {
  Future<Credits> getMovieCredits(String id);
}
