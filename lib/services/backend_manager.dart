import 'package:http/http.dart' as http;
import 'package:lostandfound/models/publications.dart';


class BackendManager{

  addPublication(Publication publication) async{
    var client = http.Client();

    try{
      String url = 'http://192.168.0.103:3000/publications';
      await client.post(Uri.parse(url),body: publication.toJson());

    }
    catch(e){
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
