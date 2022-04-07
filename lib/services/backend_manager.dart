import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/settings/const.dart';


class BackendManager{

  addPublication({required String title, required String description,required String date, required String category, required LatLng latlng, required List<File> images, required User owner , required String type}) async {
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
      var publication = Publication(
        title: title,
        description: description,
        date: date ,
        category: category,
        owner: owner,
        location: l,
        images: imgs,
        type: type,
        status:"en cours",
        tempsCreation: DateTime.now().toString(),

      );
      await client.post(Uri.parse(url), body: publication.toJson());
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