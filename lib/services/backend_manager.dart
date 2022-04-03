import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/models/publications.dart';


class BackendManager{

addPublication({required String title, required String description,required String date, required String category, required LatLng latlng, required List<File> images, required String owner , required String type}) async {
  var client = http.Client();
  try {
    String url = 'http://192.168.0.103:3000/publications';
    Location l = Location(
        coordinates: [latlng.latitude, latlng.longitude], type: "point");
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
}
