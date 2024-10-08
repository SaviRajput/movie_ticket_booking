// To parse this JSON data, do
//
//     final movieImagesResponseModel = movieImagesResponseModelFromJson(jsonString);

import 'dart:convert';

MovieImagesResponseModel movieImagesResponseModelFromJson(String str) =>
    MovieImagesResponseModel.fromJson(json.decode(str));

String movieImagesResponseModelToJson(MovieImagesResponseModel data) =>
    json.encode(data.toJson());

class MovieImagesResponseModel {
  final List<Backdrop>? backdrops;
  final int? id;
  final List<Backdrop>? logos;
  final List<Backdrop>? posters;

  MovieImagesResponseModel({
    this.backdrops,
    this.id,
    this.logos,
    this.posters,
  });

  factory MovieImagesResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieImagesResponseModel(
        backdrops: json["backdrops"] == null
            ? []
            : List<Backdrop>.from(
                json["backdrops"]!.map((x) => Backdrop.fromJson(x))),
        id: json["id"],
        logos: json["logos"] == null
            ? []
            : List<Backdrop>.from(
                json["logos"]!.map((x) => Backdrop.fromJson(x))),
        posters: json["posters"] == null
            ? []
            : List<Backdrop>.from(
                json["posters"]!.map((x) => Backdrop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "backdrops": backdrops == null
            ? []
            : List<dynamic>.from(backdrops!.map((x) => x.toJson())),
        "id": id,
        "logos": logos == null
            ? []
            : List<dynamic>.from(logos!.map((x) => x.toJson())),
        "posters": posters == null
            ? []
            : List<dynamic>.from(posters!.map((x) => x.toJson())),
      };
}

class Backdrop {
  final double? aspectRatio;
  final int? height;
  final String? iso6391;
  final String? filePath;
  final double? voteAverage;
  final int? voteCount;
  final int? width;

  Backdrop({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"]?.toDouble(),
        height: json["height"],
        iso6391: json["iso_639_1"],
        filePath: json["file_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "height": height,
        "iso_639_1": iso6391,
        "file_path": filePath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
