// To parse this JSON data, do
//
//     final publication = publicationFromJson(jsonString);

import 'dart:convert';
import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/user.dart';

List<Publication> publicationFromJson(String str) => List<Publication>.from(json.decode(str).map((x) => Publication.fromJson(x)));

String publicationToJson(List<Publication> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Publication {
  Publication(
    this.title,
    this.description,
    this.type,
    this.date,
    this.tempsCreation,
    this.category,
    this.location,
    this.images,
    this.owner,
      this.status
  );

  String title;
  String description;
  String type;
  String date;
  String tempsCreation;
  String category;
  Location location;
  List<Image> images;
  User owner;
  String status;
 static final int count = 123456789;
  factory Publication.fromJson(Map<String, dynamic> json) => Publication(
    json["title"]??"",
    json["description"]??"",
    json["type"]??"",
    json["date"]??"",
    json["tempsCreation"]??"",
    json["category"]??"",
    Location.fromJson(json["location"]),
    List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    User.fromJson(json["owner"]),
    json["status"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "type": type,
    "date": date,
    "tempsCreation":tempsCreation,
    "category": category,
    "location": location.toJson(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "owner" : owner.toJson(),
    "status":status
  };
}
