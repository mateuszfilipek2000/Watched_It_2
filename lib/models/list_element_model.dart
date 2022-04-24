import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class ListModel with EquatableMixin {
  ListModel({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int id;
  final int page;
  final List<ListElement> results;
  final int totalPages;
  final int totalResults;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        id: json["id"],
        page: json["page"],
        results: List<ListElement>.from(
            json["results"].map((x) => ListElement.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  List<Object?> get props => [id, page];
}

@immutable
class ListElement with EquatableMixin {
  ListElement({
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.itemCount,
    required this.iso6391,
    required this.listType,
    required this.name,
    required this.posterPath,
  });

  final String description;
  final int favoriteCount;
  final int id;
  final int itemCount;
  final String iso6391;
  final String listType;
  final String name;
  final String? posterPath;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        description: json["description"],
        favoriteCount: json["favorite_count"],
        id: json["id"],
        itemCount: json["item_count"],
        iso6391: json["iso_639_1"],
        listType: json["list_type"],
        name: json["name"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "favorite_count": favoriteCount,
        "id": id,
        "item_count": itemCount,
        "iso_639_1": iso6391,
        "list_type": listType,
        "name": name,
        "poster_path": posterPath,
      };

  @override
  List<Object?> get props => [id, name, description];
}
