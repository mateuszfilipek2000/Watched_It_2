class DetailedUser {
  DetailedUser({
    required this.gravatar,
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
  });

  final String gravatar;
  final int id;
  final String iso6391;
  final String iso31661;
  final String name;
  final bool includeAdult;
  final String username;

  factory DetailedUser.fromJson(Map<String, dynamic> json) => DetailedUser(
        gravatar: json["avatar"]["gravatar"]["hash"],
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        includeAdult: json["include_adult"],
        username: json["username"],
      );
}
