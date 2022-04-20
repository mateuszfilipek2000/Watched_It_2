import 'package:watched_it_2/models/tv/crew_model.dart';

class Episode {
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final DateTime airDate;
  final int episodeNumber;
  final List<Crew> crew;
  final List<Crew> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        guestStars:
            List<Crew>.from(json["guest_stars"].map((x) => Crew.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
