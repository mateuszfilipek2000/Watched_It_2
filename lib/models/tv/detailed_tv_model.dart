import 'package:watched_it_2/models/genre_model.dart';
import 'package:watched_it_2/models/network_model.dart';
import 'package:watched_it_2/models/people/person_model.dart';
import 'package:watched_it_2/models/production_country_model.dart';
import 'package:watched_it_2/models/tv/season_model.dart';
import 'package:watched_it_2/models/spoken_language_model.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';

class DetailedTv extends Tv {
  DetailedTv({
    required this.createdBy,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required DateTime firstAirDate,
    required String name,
    required int id,
    required double voteAverage,
    required int voteCount,
    required String? backdropPath,
    required List<String> originCountry,
    required String originalLanguage,
    required String originalName,
    required String overview,
    required double popularity,
    required String? posterPath,
  }) : super(
          posterPath: posterPath,
          overview: overview,
          firstAirDate: firstAirDate,
          genreIds: genres.map((e) => e.id).toList(),
          id: id,
          originalLanguage: originalLanguage,
          originalName: originalName,
          name: name,
          backdropPath: backdropPath,
          popularity: popularity,
          voteCount: voteCount,
          voteAverage: voteAverage,
          originCountry: originCountry,
        );

  final List<Person> createdBy;
  final List<int> episodeRunTime;
  final List<Genre> genres;
  final String homepage;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final LastEpisodeToAir lastEpisodeToAir;
  final dynamic nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Network> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;

  factory DetailedTv.fromJson(Map<String, dynamic> json) => DetailedTv(
        backdropPath: json["backdrop_path"],
        createdBy: List<Person>.from(
            json["created_by"].map((x) => Person.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir:
            LastEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: List<Network>.from(
            json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<Network>.from(
            json["production_companies"].map((x) => Network.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class LastEpisodeToAir {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
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
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

// class Network {
//   Network({
//     required this.name,
//     required this.id,
//     required this.logoPath,
//     required this.originCountry,
//   });

//   final String name;
//   final int id;
//   final String? logoPath;
//   final String originCountry;

//   factory Network.fromJson(Map<String, dynamic> json) => Network(
//         name: json["name"],
//         id: json["id"],
//         logoPath: json["logo_path"],
//         originCountry: json["origin_country"],
//       );
// }
