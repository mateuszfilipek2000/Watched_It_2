import 'package:watched_it_2/api/interfaces/iimage_url_provider.dart';

abstract class IMostPopularMovieImage {
  /// returns partial url, you need to use image url provider in order to get
  /// full image url
  Future<String> getMostPopularMovieImageUrl({
    required ImageType imageType,
  });
}
