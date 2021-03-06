class ApiImageConfiguration {
  const ApiImageConfiguration({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });

  final String baseUrl;
  final String secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;

  factory ApiImageConfiguration.fromJson(Map<String, dynamic> json) =>
      ApiImageConfiguration(
        baseUrl: json["base_url"],
        secureBaseUrl: json["secure_base_url"],
        backdropSizes: List<String>.from(json["backdrop_sizes"].map((x) => x)),
        logoSizes: List<String>.from(json["logo_sizes"].map((x) => x)),
        posterSizes: List<String>.from(json["poster_sizes"].map((x) => x)),
        profileSizes: List<String>.from(json["profile_sizes"].map((x) => x)),
        stillSizes: List<String>.from(json["still_sizes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "secure_base_url": secureBaseUrl,
        "backdrop_sizes": List<String>.from(backdropSizes.map((x) => x)),
        "logo_sizes": List<String>.from(logoSizes.map((x) => x)),
        "poster_sizes": List<String>.from(posterSizes.map((x) => x)),
        "profile_sizes": List<String>.from(profileSizes.map((x) => x)),
        "still_sizes": List<String>.from(stillSizes.map((x) => x)),
      };
}
