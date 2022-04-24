import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Keywords with EquatableMixin {
  const Keywords({
    required this.id,
    required this.keywords,
  });

  final int id;
  final List<Keyword> keywords;

  factory Keywords.fromJson(Map<String, dynamic> json) => Keywords(
        id: json["id"],
        keywords: List<Keyword>.from(
          json["keywords"].map(
            (e) => Keyword.fromJson(e),
          ),
        ),
      );

  @override
  List<Object?> get props => [id, keywords];
}

@immutable
class Keyword with EquatableMixin {
  Keyword({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
        id: json["id"],
        name: json["name"],
      );

  @override
  List<Object?> get props => [id, name];
}
