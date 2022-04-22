import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class IImageUrlProvider {
  /// pass size as a double from 0-100. For example:
  /// 50 to get an image of half maximum size
  /// 100 to get an image of the highest possible size
  /// 0 for the lowest quality
  getFullImageUrl({
    required String url,
    required ImageType imageType,
    required double size,
  });
}

enum ImageType {
  backdrop,
  logo,
  poster,
  profile,
  still,
}
