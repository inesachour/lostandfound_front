import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/user.dart';

//List<Publication> publicationFromJson(String str) => List<Publication>.from(json.decode(str).map((x) => Publication.fromJson(x)));
List<Publication> publicationFromJson(str) => List<Publication>.from(str.map((x) => Publication.fromJson(x)));

class Publication {
  Publication(
      this.title,
      this.description,
      this.type,
      this.date,
      this.tempsCreation,
      this.category,
      this.location,
      this.images,
      this.owner,
      this.status
      );

  String title;
  String description;
  String type;
  String date;
  String tempsCreation;
  String category;
  Location location;
  List<Image> images;
  User owner;
  String status;

  factory Publication.fromJson(Map<String, dynamic> json) {
    print('holaaaa');
    return Publication(
        json["title"]?? "",
        json["description"]?? "",
        json["type"]?? "",
        json["date"]?? "",
        json["tempsCreation"]?? "",
        json["category"] ?? "",
        Location.fromJson(json["location"]),
        List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        User.fromJson(json["owner"]),
        json["status"]??"",
    );

  }
}