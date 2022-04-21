import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/registerUserModel.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService{

  register({required String firstName, required String lastName,required String phone, File? photo, required String email , required String password, required String role, required bool verified}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/auth/v2/email/register';
      Image? img;
      if(photo != null){
        img = Image(name: "image"+photo.path.toString(), url: base64Encode(photo.readAsBytesSync()));
      }
      var user = RegisterUser(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        photo: img,
        email: email,
        password: password,
        role: role,
        verified: verified,
      );
      var response = await client.post(Uri.parse(url), body: user.toJson());
      print("khedmet !!");
      print("this is the response " + response.body.toString());
      var responseBody = jsonDecode(response.body);
      print("this is esmou " + responseBody["firstName"]);
      if(responseBody != null){
        final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        prefs.setString("email", responseBody["email"]);
        prefs.setString("_id", responseBody["_id"]);
      }
    }
    catch (e) {
      print("fama mochkla f register");
      print(e.toString());
    }
  }
  resendVerificationEmail(String email) async {
    var client = http.Client();
    try{
      String url = Const.url+'/auth/v2/email/resend-verification/${email}';
      var response = await client.get(Uri.parse(url));
      return response.body;
    }
    catch(e){
      print("mochkla f resend email");
      print(e.toString());
    }
  }

  findRegistredUser(String id) async {
    var client = http.Client();
    try {
      String url = Const.url+'/users/${id}';
      var response = await client.get(Uri.parse(url));
      var jsonString = response.body;
      return registerUserFromJson(jsonString);
    }
    catch (e) {
      print(e.toString());
    }
  }
}