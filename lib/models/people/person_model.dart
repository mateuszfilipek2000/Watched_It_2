class Person {
  const Person({
    required this.id,
    required this.gender,
    required this.name,
    required this.profilePath,
  });

  final int id;
  final int gender;
  final String name;
  final String? profilePath;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );
}
