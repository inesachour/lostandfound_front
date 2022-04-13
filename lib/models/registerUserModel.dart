import 'dart:convert';
import 'package:lostandfound/models/image.dart';

RegisterUser registerUserFromJson(String str) => RegisterUser.fromJson(json.decode(str));
String registerUserToJson(List<RegisterUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterUser {
  RegisterUser({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.photo,
    required this.email,
    required this.password,
    required this.role,
    required this.verified,
  });

  String firstName;
  String lastName;
  String phone;
  List<Image>? photo;
  String email;
  String password;
  String role;
  bool verified;

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
      firstName : json["firstName"]?? "",
      lastName: json["lastName"]?? "",
      phone: json["phone"]?? "",
      photo: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      email: json["date"]?? "",
      password: json["password"]??"",
      role: json["role"]??"",
      verified: json["verified"]??"",
    );

  }
  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "photo": photo != null ? List<dynamic>.from(photo!.map((x) => x.toJson())).toString() : [],
    "email" : email,
    "password": password,
    "role" : role,
    "verified" : verified.toString(),
  };
}
