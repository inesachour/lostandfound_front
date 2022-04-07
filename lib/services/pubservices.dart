// ignore_for_file: curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'package:lostandfound/models/publication.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';

class PubServices
{


  static Future<List<Publication>> getLostPub() async
  {
    List<Publication> _lostPublications = [];
    var response = await http.get(Uri.parse("${Const.url}/publications/"));
    print(response.body);

    if(response.statusCode==200)
    {
      print("lost te5dem");
      List<Publication> publications = publicationsFromJson(response.body) ;
      print("parse1 te5dem");

      publications.forEach((element) {
        if(element.type.toUpperCase()=="LOST")
          _lostPublications.add(element);
      });
    }
    print(_lostPublications.length);
    return _lostPublications;
  }
  static Future<List<Publication>> getFoundPub() async
  {
    List<Publication> _foundPublications = [];
    var response = await http.get(Uri.parse("${Const.url}/publications/"));
    if(response.statusCode==200)
    {
      var publications = publicationsFromJson(response.body) ;
      print("parse2 te5dem");

      publications.forEach((element) {
        if(element.type.toUpperCase()=="FOUND")
          _foundPublications.add(element);
      });
    }
    print(_foundPublications.length);

    return _foundPublications;
  }

}