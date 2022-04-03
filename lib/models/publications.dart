import 'dart:convert';


List<Publication> publicationFromJson(str) => List<Publication>.from(str.map((x) => Publication.fromJson(x)));

String publicationToJson(List<Publication> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Publication {
  Publication({
    required this.title,
    required this.description

  });

  String title;
  String description;

  factory Publication.fromJson(Map<String, dynamic> json) {
    print("this is json[0]");
    print(json[0]);
    return Publication(
        title: json["title"][0].toString().toUpperCase()+json["title"].toString().substring(1),
        description : json["description"],

    );}

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}
