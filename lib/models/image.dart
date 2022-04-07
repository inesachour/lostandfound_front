import 'dart:convert';

class Image {
  Image({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    name: json["name"],
    url: json["url"],//Base64Decoder().convert(json["url"]).toString(),
  );

  Map<String, dynamic> toJson() => {
    "\"name\"": "\""+name+"\"",
    "\"url\"": "\""+url+"\"",
  };
}