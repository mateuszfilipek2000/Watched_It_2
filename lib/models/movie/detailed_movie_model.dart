import 'package:watched_it_2/models/genre_model.dart';
import 'package:watched_it_2/models/movie/movie_model.dart';
import 'package:watched_it_2/models/production_company_model.dart';
import 'package:watched_it_2/models/production_country_model.dart';
import 'package:watched_it_2/models/spoken_language_model.dart';

class DetailedMovie extends Movie {
  DetailedMovie({
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.imdbId,
    required this.productionCompanies,
    required this.productionCountries,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required String title,
    required bool adult,
    required String? backdropPath,
    required bool video,
    required double voteAverage,
    required int voteCount,
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    required String? posterPath,
    required DateTime releaseDate,
  }) : super(
          posterPath: posterPath,
          adult: adult,
          overview: overview,
          releaseDate: releaseDate,
          genreIds: genres.map((e) => e.id).toList(),
          id: id,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          title: title,
          backdropPath: backdropPath,
          popularity: popularity,
          voteCount: voteCount,
          voteAverage: voteAverage,
          video: video,
        );

  final dynamic belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final String? imdbId;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;

  factory DetailedMovie.fromJson(Map<String, dynamic> json) => DetailedMovie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
