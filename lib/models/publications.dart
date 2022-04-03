import 'dart:convert';

Publication publicationFromJson(String str) => Publication.fromJson(json.decode(str));

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
  String date;
  String category;
  String owner;
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

class Image {
  Image({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class Location {
  Location({
    required this.coordinates,
    required this.type,
  });

  List<double> coordinates;
  String type;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    coordinates: List<double>.from(json["coordinates"].map((x) => x)),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "type": type,
  };
}
