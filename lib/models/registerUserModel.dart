import 'dart:convert';
import 'package:lostandfound/models/image.dart';

RegisterUser registerUserFromJson(String str) => RegisterUser.fromJson(json.decode(str));
String registerUserToJson(RegisterUser data) => json.encode(data.toJson());
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
  Image? photo;
  String email;
  String password;
  String role;
  bool verified;

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    print(json["photo"]);
    return RegisterUser(
      firstName: json["firstName"]?? "",
      lastName: json["lastName"]?? "",
      phone: json["phone"]?? "",
      photo: json["photo"] == null ? null : Image.fromJson(json["photo"]),
      email: json["email"]?? "",
      password: json["password"]??"",
      role: json["role"]??"",
      verified: json["verified"]??"",
    );
  }
  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "photo": photo != null ? (photo!.toJson()).toString() : "" ,
    "email" : email,
    "password": password,
    "role" : role,
    "verified" : verified.toString(),
  };
}
