// ignore_for_file: curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/constants/categories.dart';
import 'package:lostandfound/models/location.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


  Future<List<Publication>> filterPublications({required List categories, required String type, required LatLng? latlng , required DateTimeRange? dateRange}) async{

    Location? l;
    latlng != null ? l = Location(coordinates: [latlng.latitude.toString(), latlng.longitude.toString()], type: "point") : null;
    var body = {
      "categories" : json.encode(categories),
      "type": type,
      "location" : l != null ? l.toJson().toString() : '',
      "firstDate" : dateRange != null ? dateRange.start.toString() : '',
      "secondDate" : dateRange != null ? dateRange.end.toString() : '',
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

  static Future<Publication> getPublicationById(String id) async {
    var response =  await http.get(Uri.parse("${Const.url}/publications/find/$id"));
    var publication = Publication.fromJson(json.decode(response.body));
    return publication;
  }
}