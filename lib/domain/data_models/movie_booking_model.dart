// To parse this JSON data, do
//
//     final movieBookingModel = movieBookingModelFromJson(jsonString);

import 'dart:convert';

List<MovieBookingModel> movieBookingModelFromJson(String str) =>
    List<MovieBookingModel>.from(
        json.decode(str).map((x) => MovieBookingModel.fromJson(x)));

String movieBookingModelToJson(List<MovieBookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieBookingModel {
  final int? id;
  final String? name;
  final String? time;
  final List<String>? seatNumbers;
  final int? movieId;
  final String? movieImage;
  final String? ticketNumber;
  final int? cinemaId;
  final String? createdAt;
  final String? updatedAt;

  MovieBookingModel({
    this.id,
    this.name,
    this.movieImage,
    this.ticketNumber,
    this.time,
    this.cinemaId,
    this.seatNumbers,
    this.movieId,
    this.createdAt,
    this.updatedAt,
  });

  factory MovieBookingModel.fromJson(Map<String, dynamic> json) =>
      MovieBookingModel(
          id: json["id"],
          name: json["name"],
          time: json["time"],
          seatNumbers: json["seat_numbers"] == null
              ? []
              : List<String>.from(json["seat_numbers"]!.map((x) => x)),
          movieId: json["movie_id"],
          cinemaId: json["cinema_id"],
          createdAt: json["created_at"],
          updatedAt: json["updated_at"],
          movieImage: json["movie_image"],
          ticketNumber: json["ticket_number"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time,
        "seat_numbers": seatNumbers == null
            ? []
            : List<dynamic>.from(seatNumbers!.map((x) => x)),
        "movie_id": movieId,
        "cinema_id": cinemaId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "ticket_number": ticketNumber,
        "movie_image": movieImage
      };
}
