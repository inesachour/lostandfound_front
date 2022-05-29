import 'dart:convert';
import 'package:lostandfound/models/image.dart';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));
String userProfileToJson(UserProfile data) => json.encode(data.toJson());
class UserProfile {
  UserProfile({
    this.firstName,
    this.lastName,
    this.phone,
    this.photo,
    this.email,
    this.password,
    required this.role,
    required this.verified,
  });

  String? firstName;
  String? lastName;
  String? phone;
  Image? photo;
  String? email;
  String? password;
  String role;
  bool verified;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json["firstName"]?? "",
      lastName: json["lastName"]?? "",
      phone: json["phone"]?? "",
      photo: json["photo"] == "" ? null : Image.fromJson(json["photo"]),
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
