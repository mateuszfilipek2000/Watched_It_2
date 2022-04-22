class LanguageConfiguration {
  const LanguageConfiguration({
    required this.iso6391,
    required this.englishName,
    required this.name,
  });

  final String iso6391;
  final String englishName;
  final String name;

  factory LanguageConfiguration.fromJson(Map<String, dynamic> json) =>
      LanguageConfiguration(
        iso6391: json["iso_639_1"],
        englishName: json["english_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "english_name": englishName,
        "name": name,
      };
}
