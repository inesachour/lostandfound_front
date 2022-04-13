import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/registerUserModel.dart';
import 'package:lostandfound/settings/const.dart';


class RegisterService{

  register({required String firstName, required String lastName,required String phone, List<File>? photo, required String email , required String password, required String role, required bool verified}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/users';
      List<Image> imgs = [];
      int i = 1;
      if(photo != null){
        photo.forEach((element) {
          imgs.add(Image(name: "image"+i.toString(), url: base64Encode(element.readAsBytesSync())));
          i++;
        });
      }
      var user = RegisterUser(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        photo: imgs,
        email: email,
        password: password,
        role: role,
        verified: verified,
      );
      await client.post(Uri.parse(url), body: user.toJson());
      print("khedmet !!");
    }
    catch (e) {
      print("mochkla");
      print(e.toString());
    }
  }
}