import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class TvAggregatedCredits with EquatableMixin {
  const TvAggregatedCredits({
    required this.id,
    required this.cast,
    required this.crew,
  });
  final int id;
  final List<TvAggregatedCrew> crew;
  final List<TvAggregatedCast> cast;

  factory TvAggregatedCredits.fromJson(Map<String, dynamic> json) =>
      TvAggregatedCredits(
        id: json["id"],
        cast: List<TvAggregatedCast>.from(
            json["cast"].map((e) => TvAggregatedCast.fromJson(e))),
        crew: List<TvAggregatedCrew>.from(
            json["crew"].map((e) => TvAggregatedCrew.fromJson(e))),
      );

  @override
  List<Object?> get props => [id];
}

abstract class TvAggregatedCrewCastBase {
  const TvAggregatedCrewCastBase({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.totalEpisodeCount,
  });

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int totalEpisodeCount;
}

class TvAggregatedCast extends TvAggregatedCrewCastBase {
  const TvAggregatedCast({
    required bool adult,
    required int gender,
    required int id,
    required String knownForDepartment,
    required String name,
    required String originalName,
    required double popularity,
    required String? profilePath,
    required int totalEpisodeCount,
    required this.castId,
    required this.roles,
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
          totalEpisodeCount: totalEpisodeCount,
        );
  final int castId;
  final List<Role> roles;
  final int order;

  factory TvAggregatedCast.fromJson(Map<String, dynamic> json) =>
      TvAggregatedCast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        order: json["order"],
        roles: json["roles"].map((e) => Role.fromJson(e)),
        castId: json["cast_id"],
        totalEpisodeCount: json["total_episode_count"],
      );
}

class TvAggregatedCrew extends TvAggregatedCrewCastBase {
  const TvAggregatedCrew({
    required bool adult,
    required int gender,
    required int id,
    required String knownForDepartment,
    required String name,
    required String originalName,
    required double popularity,
    required String? profilePath,
    required int totalEpisodeCount,
    required this.department,
    required this.jobs,
  }) : super(
          adult: adult,
          gender: gender,
          id: id,
          knownForDepartment: knownForDepartment,
          name: name,
          originalName: originalName,
          popularity: popularity,
          profilePath: profilePath,
          totalEpisodeCount: totalEpisodeCount,
        );
  final String department;
  final List<Job> jobs;

  factory TvAggregatedCrew.fromJson(Map<String, dynamic> json) =>
      TvAggregatedCrew(
        department: json["department"],
        jobs: json["jobs"].map((e) => Job.fromJson(e)),
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        totalEpisodeCount: json["total_episode_count"],
      );
}

class Role {
  const Role({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  final String creditId;
  final String character;
  final int episodeCount;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        creditId: json["credit_id"],
        character: json["character"],
        episodeCount: json["episode_count"],
      );
}

class Job {
  const Job({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  final String creditId;
  final String job;
  final int episodeCount;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        creditId: json["credit_id"],
        job: json["job"],
        episodeCount: json["episode_count"],
      );
}
