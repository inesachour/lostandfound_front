import 'package:lostandfound/models/image.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userProf.dart';

class UsersService{

  static Future<User?> findUser({required String userId}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/users/'+ userId;
      var result = await client.get(Uri.parse(url));
      return User.fromJson(json.decode(result.body));
    }
    catch (e) {
      print(e.toString());
    }
  }

  static Future<UserProfile?> findUserProfile({required String userId}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/users/'+ userId;
      var result = await client.get(Uri.parse(url));
      return UserProfile.fromJson(json.decode(result.body));
    }
    catch (e) {
      print(e.toString());
    }
  }

  updateUser({required id, String? firstName, String? lastName, String? phone, File? photo,  String? email ,  String? password, required String role, required bool verified}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/users/update/${id}';
      Image? img;
      if(photo != null){
        img = Image(name: "image"+photo.path.toString(), url: base64Encode(photo.readAsBytesSync()));
      }
      var user = UserProfile(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        photo: img,
        email: email,
        password: password,
        role: role,
        verified: verified,
      );
      var response = await client.patch(Uri.parse(url), body: user.toJson());
      print("khedmet !!");
      print("hedhyyyyy response " + response.body.toString());
      var responseBody = jsonDecode(response.body);
      print("this is esmou " + responseBody["firstName"]);
      if(responseBody != null){
        final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        prefs.setString("_id", responseBody["_id"]);
      }
    }
    catch (e) {
      print("fama mochkla f update");
      print(e.toString());
    }
  }
}