abstract class CrewCastBase {
  const CrewCastBase({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
}

class Cast extends CrewCastBase {
  const Cast({
    required bool adult,
    required int gender,
    required int id,
    required String knownForDepartment,
    required String name,
    required String originalName,
    required double popularity,
    required String? profilePath,
    required this.castId,
    required this.character,
    required this.order,
  }) : super(
          adult: adult,
          gender: gender,
          id: id,
          knownForDepartment: knownForDepartment,
          name: name,
          originalName: originalName,
          popularity: popularity,
          profilePath: profilePath,
        );
  final int castId;
  final String character;
  final int order;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        // department: json["department"],
        // job: json["job"],
        // creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        order: json["order"],
        character: json["character"],
        castId: json["cast_id"],
      );
}

class Crew extends CrewCastBase {
  const Crew({
    required bool adult,
    required int gender,
    required int id,
    required String knownForDepartment,
    required String name,
    required String originalName,
    required double popularity,
    required String? profilePath,
    required this.department,
    required this.job,
  }) : super(
          adult: adult,
          gender: gender,
          id: id,
          knownForDepartment: knownForDepartment,
          name: name,
          originalName: originalName,
          popularity: popularity,
          profilePath: profilePath,
        );
  final String department;
  final String job;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        department: json["department"],
        job: json["job"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
      );
}
