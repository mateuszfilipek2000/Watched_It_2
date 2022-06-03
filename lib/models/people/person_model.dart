import 'package:watched_it_2/models/idisplayable.dart';

class Person implements IDisplayable {
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

  @override
  String? get backdropPath => null;

  @override
  String? get posterPath => profilePath;

  @override
  String? get subtitle => null;

  @override
  String get title => name;
}
