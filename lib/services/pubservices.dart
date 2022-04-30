// ignore_for_file: curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:lostandfound/constants/categories.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';

class PubServices
{


  static Future<List<Publication>> getLostPub() async
  {
    List<Publication> _lostPublications = [];
    var response = await http.get(Uri.parse("${Const.url}/publications/"));

    if(response.statusCode==200)
    {
      List<Publication> publications = publicationsFromJson(response.body) ;

      publications.forEach((element) {
        if(element.type.toUpperCase()=="LOST")
          _lostPublications.add(element);
      });
    }
    return _lostPublications;
  }
  static Future<List<Publication>> getFoundPub() async
  {
    List<Publication> _foundPublications = [];
    var response = await http.get(Uri.parse("${Const.url}/publications/"));
    if(response.statusCode==200)
    {
      var publications = publicationsFromJson(response.body) ;

      publications.forEach((element) {
        if(element.type.toUpperCase()=="FOUND")
          _foundPublications.add(element);
      });
    }

    return _foundPublications;
  }


  Future<List<Publication>> filterPublications({required List categories, required String type}) async{

    var body = {
      "categories" : json.encode(categories),
      "type": type
    };

    List<Publication> publications = [];
    try{
      var response = await http.post(Uri.parse("${Const.url}/publications/filter"),body: body);
      publications = publicationsFromJson(response.body);

    }catch(e){
      print(e);
    }
    return publications;
  }
}