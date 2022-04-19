import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lostandfound/models/user.dart';

List<Comment> commentsFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentsToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  String dateCreation;
  String? dateModification;
  String commentOwner;
  String publication;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      text: json["text"],
      dateCreation: json["dateCreation"],
      dateModification: json["dateModification"],
      commentOwner: json["commentOwner"],
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
