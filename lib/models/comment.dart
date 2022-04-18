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
    required this.commentOwner,
    required this.publication
  });

  String text;
  DateTime dateCreation;
  DateTime? dateModification;
  String commentOwner;
  String publication;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      text: json["text"],
      dateCreation: json["dateCreation"],
      dateModification: json["dateModification"],
      commentOwner: "user",
      publication: json["publication"]
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "dateCreation": dateCreation.toString(),
    "dateModification" : dateModification.toString(),
    "commentOwner" : commentOwner,
    "publication" : publication
  };
}
