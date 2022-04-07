// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    required this.coordinates,
    required this.type,
  });

  List<String> coordinates;
  String type;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    coordinates: List<String>.from(json["coordinates"].map((x) => x.toString())),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "type": type,
  };
}
