abstract class IMostPopularMoviePoster {
  /// returns partial url, you need to use image url provider in order to get
  /// full image url
  Future<String> getMostPopularMoviePosterUrl();
}
