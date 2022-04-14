import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lostandfound/models/user.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.text,
    required this.dateCreation,
    this.dateModification,
    required this.owner,
  });

  String text;
  DateTime dateCreation;
  DateTime? dateModification;
  User owner;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    text: json["text"],
    dateCreation: json["dateCreation"],
    dateModification: json["dateModification"],
    owner: User.fromJson(json["owner"])
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "dateCreation": dateCreation,
    "dateModification" : dateModification,
    "owner" : owner.toJson().toString()
  };
}
