import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lostandfound/models/publication.dart';

class BackendManager{

  Future<List<Publication>> getPublications(String search) async {
    var client = http.Client();
    List<Publication> publications = [];
    try{
      String url = 'http://192.168.43.116:3000/publications?search=$search';
      var response = await client.get(Uri.parse(url));
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      publications = publicationFromJson(jsonMap);
      print("fadit");
      print(response.body);
    }
    catch(e){
      print('mochkla kbira');
      print(e.toString());
    }
    return publications;
  }
}