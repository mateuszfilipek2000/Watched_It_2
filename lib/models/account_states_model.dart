import 'package:equatable/equatable.dart';

class AccountStates with EquatableMixin {
  AccountStates({
    required this.id,
    required this.favorite,
    required this.rated,
    required this.watchlist,
  });

  final int id;
  final bool favorite;
  final double? rated;
  final bool watchlist;

  factory AccountStates.fromJson(Map<String, dynamic> json) => AccountStates(
        id: json["id"],
        favorite: json["favorite"],
        rated: double.tryParse(json['rated']['value'].toString()),
        watchlist: json["watchlist"],
      );

  @override
  List<Object?> get props => [id, favorite, rated, watchlist];
}
