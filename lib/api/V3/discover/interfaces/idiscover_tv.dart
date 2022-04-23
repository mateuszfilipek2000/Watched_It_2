import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/models/tv/tv_model.dart';

@immutable
abstract class IDiscoverTv {
  /// returns results as
  /// int page: List<Tv>
  Future<List<Tv>> getDiscoverTv(int page);
}
