// To parse this JSON data, do
//
//     final publication = publicationFromJson(jsonString);

import 'dart:convert';

Publication publicationFromJson(String str) => Publication.fromJson(json.decode(str));

String publicationToJson(Publication data) => json.encode(data.toJson());

class Publication {
  Publication({
    required this.title,
    required this.description,
    required this.user,
  });

  String title;
  String description;
  String user;

  factory Publication.fromJson(Map<String, dynamic> json) => Publication(
    title: json["title"],
    description: json["description"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "user": user,
  };
}

