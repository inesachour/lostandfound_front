// ignore_for_file: curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'package:flutter/foundation.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PubServices extends ChangeNotifier
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

   static Future deletePub(String id) async
  {
    await http.delete(Uri.parse("${Const.url}/publications/$id"));
  }


  static Future<List<Publication>> getMyPubs() async
  {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var idUser= sp.getString("userId");
    List<Publication> _pubs = [];
    var response = await http.get(Uri.parse("${Const.url}/publications/$idUser"));
    if(response.statusCode==200)
    {
      _pubs = publicationsFromJson(response.body) ;
    }
    return _pubs;

  }

  static Future updatePub(String id, String title,String description) async
  {
    return await http.patch(Uri.parse("${Const.url}/publications/$id"),
    body: {
      "title" : title,
      "description" : description
    }
    );
  }
}