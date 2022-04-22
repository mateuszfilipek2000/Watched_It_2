class CountryConfiguration {
  const CountryConfiguration({
    required this.iso31661,
    required this.englishName,
  });

  final String iso31661;
  final String englishName;

  factory CountryConfiguration.fromJson(Map<String, dynamic> json) =>
      CountryConfiguration(
        iso31661: json["iso_3166_1"],
        englishName: json["english_name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "english_name": englishName,
      };
}
