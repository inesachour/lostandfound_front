import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.photo,
  });

  String? id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String photo;


  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["_id"],
      firstName: json["firstName"],
      lastName:json["lastName"],
      phone: json["phone"],
      email: json["email"],
      photo: json["photo"]
  );

  Map<String, dynamic> toJson() => {
    "\"firstName\"": "\""+firstName+"\"",
    "\"lastName\"": "\""+lastName+"\"",
    "\"phone\"": "\""+phone+"\"",
    "\"email\"": "\""+email+"\"",
    "\"photo\"" : "\""+photo+"\""
  };

  Map<String, dynamic> toJsonWithId() => {
    "\"_id\"": "\""+id!+"\"",
    "\"firstName\"": "\""+firstName+"\"",
    "\"lastName\"": "\""+lastName+"\"",
    "\"phone\"": "\""+phone+"\"",
    "\"email\"": "\""+email+"\"",
    "\"photo\"" : "\""+photo+"\""
  };
}