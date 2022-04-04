import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.photo
  });

  String firstName;
  String lastName;
  String phone;
  String email;
  String photo;


  factory User.fromJson(Map<String, dynamic> json) => User(
      firstName: json["first_name"],
      lastName:json["last_name"],
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
}