import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/models/image.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/models/user.dart';


class BackendManager{

addPublication({required String title, required String description,required String date, required String category, required LatLng latlng, required List<File> images, required String owner , required String type}) async {
  var client = http.Client();
  try {
    String url = 'http://192.168.0.103:3000/publications';
    DateTime d = DateTime.parse(date);
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
        date: d ,
        category: category,
        owner: User(phone: "",photo: "",lastName: "",firstName: "",email: ""),
        location: l,
        images: imgs,
        type: type,
    );
    await client.post(Uri.parse(url), body: publication.toJson());
  }
  catch (e) {
    print(e.toString());
  }
}

  /* TO DECODE IMAGE
  Future<Uint8List?> getPhoto() async {
    var client = http.Client();

    try{
      String url = 'http://192.168.0.103:3000/publications/photo';
      var resp = await client.get(Uri.parse(url));
      var file = Base64Decoder().convert(resp.body);
    "images" : images.map((e) => base64Encode(e.readAsBytesSync()))

      return file;
    }catch(e){

    }
  }
   */

Future<List<Publication>> getPublications(String search) async {
  var client = http.Client();
  List<Publication> publications = [];
  try{
    String url = 'http://192.168.43.116:3000/publications?search=$search';
    var response = await client.get(Uri.parse(url));
    var jsonString = response.body;
    //var jsonMap = json.decode(jsonString);
    publications = publicationFromJson(jsonString);
    print(response.body);
  }
  catch(e){
    print('mochkla kbira');
    print(e.toString());
  }
  return publications;
}
}