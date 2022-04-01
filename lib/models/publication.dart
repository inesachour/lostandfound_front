// To parse this JSON data, do
//
//     final publication = publicationFromJson(jsonString);

import 'dart:convert';

import 'package:lostandfound/models/user.dart';

List<Publication> publicationFromJson(String str) => List<Publication>.from(json.decode(str).map((x) => Publication.fromJson(x)));

String publicationToJson(List<Publication> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Publication {
  Publication(
    this.title,
    this.description,
    this.type,
    this.date,
    this.location,
    this.imagesUrl,
    this.owner
  );

  String title;
  String description;
  String type;
  DateTime date;
  Location location;
  List<String> imagesUrl;
  User owner;

  factory Publication.fromJson(Map<String, dynamic> json) => Publication(
    json["title"],
    json["description"],
    json["type"],
    DateTime.parse(json["date"]),
    Location.fromJson(json["location"]),
    List<String>.from(json["images_url"].map((x) => x)),
    User.fromJson(json["owner"])
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "type": type,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "location": location.toJson(),
    "images_url": List<dynamic>.from(imagesUrl.map((x) => x)),
    "owner" : owner.toJson()
  };
}

class Location {
  Location(
    this.type,
    this.coordinates,
  );

  String type;
  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    json["type"],
    List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}
