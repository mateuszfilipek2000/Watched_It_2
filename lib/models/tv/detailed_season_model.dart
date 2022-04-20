import 'package:watched_it_2/models/tv/episode_model.dart';

// TODO ???ID IS A STRING??? MAKE A CHILD OF SEASON MODEL
class DetailedSeason {
  DetailedSeason({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final DateTime airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int seasonId;
  final String posterPath;
  final int seasonNumber;

  factory DetailedSeason.fromJson(Map<String, dynamic> json) => DetailedSeason(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );
}
