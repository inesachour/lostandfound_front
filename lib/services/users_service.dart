
import 'dart:convert';

import 'package:lostandfound/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/settings/const.dart';

class UsersService{

  static Future<User?> findUser({required String userId}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/users/'+ userId;
      var result = await client.get(Uri.parse(url));
      print(User.fromJson(json.decode(result.body)));
      return User.fromJson(json.decode(result.body));
    }
    catch (e) {
      print(e.toString());
    }
  }
}