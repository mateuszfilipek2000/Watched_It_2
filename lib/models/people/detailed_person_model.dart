import 'package:watched_it_2/models/people/person_model.dart';

class DetailedPerson extends Person {
  DetailedPerson({
    required this.birthday,
    required this.knownForDepartment,
    required this.deathday,
    required this.alsoKnownAs,
    required this.biography,
    required this.popularity,
    required this.placeOfBirth,
    required this.adult,
    required this.imdbId,
    required this.homepage,
    required int id,
    required String name,
    required String? profilePath,
    required int gender,
  }) : super(
          id: id,
          name: name,
          gender: gender,
          profilePath: profilePath,
        );

  final DateTime? birthday;
  final String knownForDepartment;
  final DateTime? deathday;
  final List<String> alsoKnownAs;
  final String biography;
  final double popularity;
  final String? placeOfBirth;
  final bool adult;
  final String imdbId;
  final String? homepage;

  factory DetailedPerson.fromJson(Map<String, dynamic> json) => DetailedPerson(
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        knownForDepartment: json["known_for_department"],
        deathday:
            json["deathday"] == null ? null : DateTime.parse(json["deathday"]),
        id: json["id"],
        name: json["name"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        gender: json["gender"],
        biography: json["biography"],
        popularity: json["popularity"].toDouble(),
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"],
      );
}
