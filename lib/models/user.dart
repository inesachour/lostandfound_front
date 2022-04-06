import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.photo
      );

  String firstName;
  String lastName;
  String phone;
  String email;
  String photo;


  factory User.fromJson(Map<String, dynamic> json) => User(
      json["firstName"],
      json["lastName"],
      json["phone"],
      json["email"],
      json["photo"]
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
    "photo" : photo
  };
}