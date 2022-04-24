import 'package:watched_it_2/models/network_model.dart';

class EpisodeGroup {
  EpisodeGroup({
    required this.description,
    required this.episodeCount,
    required this.groupCount,
    required this.id,
    required this.name,
    required this.network,
    required this.type,
  });

  final String description;
  final int episodeCount;
  final int groupCount;
  final String id;
  final String name;
  final Network? network;
  final int type;

  factory EpisodeGroup.fromJson(Map<String, dynamic> json) => EpisodeGroup(
        description: json["description"],
        episodeCount: json["episode_count"],
        groupCount: json["group_count"],
        id: json["id"],
        name: json["name"],
        network:
            json["network"] == null ? null : Network.fromJson(json["network"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "episode_count": episodeCount,
        "group_count": groupCount,
        "id": id,
        "name": name,
        "network": network == null ? null : network!.toJson(),
        "type": type,
      };
}
