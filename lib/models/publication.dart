import 'dart:convert';

import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/user.dart';

Publication publicationFromJson(String str) => Publication.fromJson(json.decode(str));

List<Publication> publicationsFromJson(String str) => List<Publication>.from(json.decode(str).map((x) => Publication.fromJson(x)));

String publicationToJson(Publication data) => json.encode(data.toJson());

class Publication {
  Publication({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.owner,
    required this.location,
    required this.images,
    required this.type,
  });

  String title;
  String description;
  DateTime date;
  String category;
  User owner;
  Location location;
  List<Image> images;
  String type;

  factory Publication.fromJson(Map<String, dynamic> json) => Publication(
    title: json["title"],
    description: json["description"],
    date: json["date"],
    category: json["category"],
    owner: json["owner"],
    location: Location.fromJson(json["location"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "date": date.toString(),
    "category": category,
    "owner": owner,
    "location": location.toJson().toString(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())).toString(),
    "type": type,
  };
}




