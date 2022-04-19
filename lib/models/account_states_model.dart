class AccountStates {
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
        rated: json['rated']['value'],
        watchlist: json["watchlist"],
      );
}
