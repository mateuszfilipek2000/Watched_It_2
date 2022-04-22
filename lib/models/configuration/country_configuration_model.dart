class CountryConfiguration {
  const CountryConfiguration({
    required this.countries,
  });

  final List<Country> countries;

  factory CountryConfiguration.fromJson(Map<String, dynamic> json) =>
      CountryConfiguration(
        countries: List<Country>.from(
            json["countries"].map((e) => Country.fromJson(e))),
      );

  Map<String, dynamic> toJson() => {
        "countries": countries.map((e) => e.toJson()).toList(),
      };
}

class Country {
  const Country({
    required this.iso31661,
    required this.englishName,
  });

  final String iso31661;
  final String englishName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        iso31661: json["iso_3166_1"],
        englishName: json["english_name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "english_name": englishName,
      };
}
