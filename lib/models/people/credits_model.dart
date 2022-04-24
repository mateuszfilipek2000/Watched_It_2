import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:watched_it_2/models/crew_model.dart';

@immutable
class Credits with EquatableMixin {
  const Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });
  final int id;
  final List<Crew> crew;
  final List<Cast> cast;

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((e) => Cast.fromJson(e))),
        crew: List<Crew>.from(json["crew"].map((e) => Crew.fromJson(e))),
      );

  @override
  List<Object?> get props => [id];
}
