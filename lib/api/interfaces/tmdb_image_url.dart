import 'dart:developer';

import 'package:watched_it_2/api/V3/configuration/interfaces/iimageconfiguration.dart';
import 'package:watched_it_2/api/interfaces/iimage_url.dart';

class TmdbImageUrlProvider implements IImageUrl {
  const TmdbImageUrlProvider(this.imageConfigurationProvider);

  @override
  getFullImageUrl({
    required String url,
    required ImageType imageType,
    required double size,
  }) async {
    if (size < 0 || size > 100) {
      log("size outside of acceptable range, size = $size");
      throw const FormatException("Size needs to be between 0 and 100");
    }

    final imageConfiguration =
        await imageConfigurationProvider.getImageConfiguration();

    final secureBase = imageConfiguration.secureBaseUrl;

    // quality index is the closest index after dividing target size
    // by the length of the array containing all available target sizes
    switch (imageType) {
      case ImageType.logo:
        final qualityIndex =
            (size / 100 * imageConfiguration.logoSizes.length).round();
        return secureBase + imageConfiguration.logoSizes[qualityIndex] + url;
      case ImageType.backdrop:
        final qualityIndex =
            (size / 100 * imageConfiguration.backdropSizes.length).round();
        return secureBase +
            imageConfiguration.backdropSizes[qualityIndex] +
            url;
      case ImageType.poster:
        final qualityIndex =
            (size / 100 * imageConfiguration.posterSizes.length).round();
        return secureBase + imageConfiguration.posterSizes[qualityIndex] + url;
      case ImageType.still:
        final qualityIndex =
            (size / 100 * imageConfiguration.stillSizes.length).round();
        return secureBase + imageConfiguration.stillSizes[qualityIndex] + url;
      case ImageType.profile:
        final qualityIndex =
            (size / 100 * imageConfiguration.profileSizes.length).round();
        return secureBase + imageConfiguration.profileSizes[qualityIndex] + url;
    }
  }

  final IImageConfiguration imageConfigurationProvider;
}
