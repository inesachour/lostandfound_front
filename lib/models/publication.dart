import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/user.dart';
import 'dart:convert';

import 'package:lostandfound/models/userProf.dart';

Publication publicationFromJson(String str) => Publication.fromJson(json.decode(str));

List<Publication> publicationsFromJson(String str) => List<Publication>.from(json.decode(str).map((x) => Publication.fromJson(x)));

String publicationToJson(List<Publication> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Publication {
  Publication({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    required this.tempsCreation,
    required this.category,
    required this.location,
    required this.images,
    required this.owner,
    required this.status
  });

  String? id;
  String title;
  String description;
  String type;
  String date;
  String? tempsCreation;
  String category;
  Location location;
  List<Image> images;
  User owner;
  String status;

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      id: json["_id"],
      title : json["title"]?? "",
      description: json["description"]?? "",
      type: json["type"]?? "",
      date: json["date"]?? "",
      tempsCreation:  json["tempsCreation"]?? "",
      category: json["category"] ?? "",
      location: Location.fromJson(json["location"]),
      images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      owner: User.fromJson(json["owner"]),
      status : json["status"]??"",
    );

  }
  Map<String, dynamic> toJson() {
    print("ok to json");
    return {
      "title": title,
      "description": description,
      "type": type,
      "date": date,
      "tempsCreation":tempsCreation,
      "category": category,
      "location": location.toJson().toString(),
      "images": List<dynamic>.from(images.map((x) => x.toJson())).toString(),
      "owner" : owner.toJsonWithId().toString(),
      "status":status
    };

  }
}
