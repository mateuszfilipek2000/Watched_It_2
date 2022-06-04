import 'dart:developer';
import 'package:watched_it_2/api/interfaces/iimage_url_provider.dart';
import 'package:watched_it_2/models/configuration/image_configuration_model.dart';

class TmdbImageUrlProvider implements IImageUrlProvider {
  const TmdbImageUrlProvider({
    required this.imageConfiguration,
  });

  @override
  String getFullImageUrl({
    required String url,
    required ImageType imageType,
    required double size,
  }) {
    if (size < 0 || size > 100) {
      log("size outside of acceptable range, size = $size");
      throw const FormatException("Size needs to be between 0 and 100");
    }

    // final imageConfiguration =
    //     await imageConfigurationProvider.getImageConfiguration();

    final secureBase = imageConfiguration.secureBaseUrl;

    // quality index is the closest index after dividing target size
    // by the length of the array containing all available target sizes
    switch (imageType) {
      case ImageType.logo:
        final qualityIndex =
            (size / 100 * (imageConfiguration.logoSizes.length - 1)).round();
        return secureBase + imageConfiguration.logoSizes[qualityIndex] + url;
      case ImageType.backdrop:
        final qualityIndex =
            (size / 100 * (imageConfiguration.backdropSizes.length - 1))
                .round();
        return secureBase +
            imageConfiguration.backdropSizes[qualityIndex] +
            url;
      case ImageType.poster:
        final qualityIndex =
            (size / 100 * (imageConfiguration.posterSizes.length - 1)).round();
        return secureBase + imageConfiguration.posterSizes[qualityIndex] + url;
      case ImageType.still:
        final qualityIndex =
            (size / 100 * (imageConfiguration.stillSizes.length - 1)).round();
        return secureBase + imageConfiguration.stillSizes[qualityIndex] + url;
      case ImageType.profile:
        final qualityIndex =
            (size / 100 * (imageConfiguration.profileSizes.length - 1)).round();
        return secureBase + imageConfiguration.profileSizes[qualityIndex] + url;
    }
  }

  @override
  final ApiImageConfiguration imageConfiguration;
}
