
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static Future Login(String email,String pwd) async {
    var response = await http.post(
      Uri.parse("${Const.url}/auth"),
      body: {
        "email" : email,
        "password" : pwd
      }
    );
    var bodyRes=jsonDecode(response.body);
    if(bodyRes["status"]==null) {
      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      prefs.setStringList(
          'tokenInfo', [bodyRes["token"], bodyRes["expiresIn"].toString()]
      );
      print(bodyRes["userId"].toString());
      prefs.setString("userId", bodyRes["userId"].toString());
      return true;
    }
    else
      {
        return bodyRes["message"];
      }
  }

  static Future Logout() async{
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if(prefs.containsKey("tokenInfo"))
      {
        prefs.remove("tokenInfo");
        prefs.remove("userId");
      }
    return true;
  }
}
