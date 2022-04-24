import 'package:equatable/equatable.dart';

class Images with EquatableMixin {
  Images({
    required this.id,
    required this.backdrops,
    required this.posters,
  });

  final int id;
  final List<ImageModel> backdrops;
  final List<ImageModel> posters;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        backdrops: List<ImageModel>.from(
            json["backdrops"].map((x) => ImageModel.fromJson(x))),
        posters: List<ImageModel>.from(
            json["posters"].map((x) => ImageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "backdrops": List<dynamic>.from(backdrops.map((x) => x.toJson())),
        "posters": List<dynamic>.from(posters.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [id];
}

class ImageModel {
  ImageModel({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.iso6391,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  final double aspectRatio;
  final String filePath;
  final int height;
  final String? iso6391;
  final int voteAverage;
  final int voteCount;
  final int width;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "file_path": filePath,
        "height": height,
        "iso_639_1": iso6391,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
