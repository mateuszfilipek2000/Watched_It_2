import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/widgets.dart';
import 'package:watched_it_2/models/configuration/image_configuration_model.dart';

@immutable
abstract class IImageUrlProvider {
  /// pass size as a double from 0-100. For example:
  /// 50 to get an image of half maximum size
  /// 100 to get an image of the highest possible size
  /// 0 for the lowest quality
  String getFullImageUrl({
    required String url,
    required ImageType imageType,
    required double size,
  });

  abstract final ApiImageConfiguration imageConfiguration;
}

enum ImageType {
  backdrop,
  logo,
  poster,
  profile,
  still,
}
