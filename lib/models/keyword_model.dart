class Keyword {
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
}
