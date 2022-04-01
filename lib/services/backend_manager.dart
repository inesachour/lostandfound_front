import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/models/publications.dart';


class BackendManager{

addPublication({required String title, required String description,required String date, required String category, required LatLng latlng, required List<File> images, required String owner }) async {
  var client = http.Client();
  try {
    String url = 'http://192.168.0.103:3000/publications';
    DateTime d = DateTime.parse(date);
    Location l = Location(
        coordinates: [latlng.latitude, latlng.longitude], type: "point");
    List<Image> imgs = [];
    images.forEach((element) {
      imgs.add(Image(name: "test", url: element.path));
    });
    var publication = Publication(title: title,
        description: description,
        date: d,
        category: category,
        owner: owner,
        location: l,
        images: imgs);
    await client.post(Uri.parse(url), body: publication.toJson());
  }
  catch (e) {
    print(e.toString());
  }
}
  /*addPublication(Publication publication) async{
    var client = http.Client();
    try{
      String url = 'http://192.168.0.103:3000/publications';
      await client.post(Uri.parse(url),body: publication.toJson());

    }
    catch(e){
      print(e.toString());
    }
  }*/

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
