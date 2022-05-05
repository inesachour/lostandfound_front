import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BackendManager extends ChangeNotifier{
  static BackendManager _BackendManager = BackendManager();
  static BackendManager get getBackendManager => _BackendManager;

  Future addPublication({required String title, required String description,required String date, required String category, required LatLng latlng, required List<File> images, required User owner , required String type}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/publications';
      Location l = Location(
          coordinates: [latlng.latitude.toString(), latlng.longitude.toString()], type: "point");
      List<Image> imgs = [];
      int i =1;
      images.forEach((element) {
        imgs.add(Image(name: "image"+i.toString(), url: base64Encode(element.readAsBytesSync())));
        i++;
      });

      //get current user
      SharedPreferences sp = await SharedPreferences.getInstance();
      var idUser= sp.getString("userId");
      var user = await http.get(Uri.parse("${Const.url}/users/$idUser"));



      var publication = Publication(
        title: title,
        description: description,
        date: date ,
        category: category,
        owner: User.fromJson(jsonDecode(user.body)),//owner,
        location: l,
        images: imgs,
        type: type,
        status:"en cours",
        tempsCreation: DateTime.now().toString(),

      );
      var result = await client.post(Uri.parse(url), body: publication.toJson());
      if(result.statusCode==201)
        notifyListeners();
    }
    catch (e) {
      print(e.toString());
    }
  }

  Future<List<Publication>> getPublications(String search) async {
    var client = http.Client();
    List<Publication> publications = [];
    try{
      String url = Const.url+'/publications?search=$search';
      var response = await client.get(Uri.parse(url));
      var jsonString = response.body;
      publications = publicationsFromJson(jsonString);
    }
    catch(e){
      print(e.toString());
    }
    return publications;
  }
}