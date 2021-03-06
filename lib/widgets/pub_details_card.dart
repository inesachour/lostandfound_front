import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:http/http.dart';
//import 'package:geocode/geocode.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/models/userProf.dart';
import 'package:lostandfound/screens/addpublication.dart';
import 'package:lostandfound/screens/modifprofile.dart';
import 'package:lostandfound/screens/sendmessage.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/map.dart';

class PublicationDetailsCard extends StatefulWidget {
  PublicationDetailsCard({required this.publication});

  Publication publication;

  @override
  State<PublicationDetailsCard> createState() => _PublicationDetailsCardState();
}

class _PublicationDetailsCardState extends State<PublicationDetailsCard> {

  UserProfile? user;
  String location= "";
  @override
  void initState() {
    super.initState();
    final coordinates = new Coordinates(
        double.parse(widget.publication.location.coordinates[0]),
        double.parse(widget.publication.location.coordinates[1])
    );
    Geocoder.local.findAddressesFromCoordinates(coordinates).then((c) {
      if(mounted){
        setState(() {
          location = "${c.first.adminArea ?? ""} ${c.first.subAdminArea ?? ""}";
        });
      }

    });
  }


  @override
  Widget build(BuildContext context) {

    UsersService.findUserProfile(userId: widget.publication.owner.id!).then((value) {
      if(user==null){
        if(mounted){
          setState(() {
            user=value;
          });
        }

      }
    }
    );

    double lat = double.parse(widget.publication.location.coordinates[0]);
    double long = double.parse(widget.publication.location.coordinates[1]);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Colors.white,
          border: Border.all(
            color: darkGrey
          ),
      ),
      child: Column(
        children: [

          SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(
                  icon: Icon(Icons.message, color: darkGrey,),
                  onPressed: (){
                    Navigator.of(context).pushNamed("/sendMessage",arguments: widget.publication.owner);
                  }
              ),

              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: darkGrey,
                    radius: MediaQuery.of(context).size.width * 0.05,
                    child: user == null || user?.photo == null
                        ? Icon(Icons.account_circle_rounded,
                        color: primaryBackground)
                        : ClipOval(
                      child: Image.memory(
                        Base64Decoder().convert(user!.photo!.url),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    //widget.publication.owner.firstName+ " "+ widget.publication.owner.lastName,
                    user != null && user!.firstName != null ? user!.firstName! + " " + user!.lastName! : "",
                    style: TextStyle(color: darkGrey),
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.mail, color: darkGrey),
                  onPressed: (){

                  }
              ),
            ],
          ),
          Divider(color: darkGrey,indent: 5,endIndent: 5,),


          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Titre :", style: TextStyle(color: primaryBlue),),
                          SizedBox(height: 5,),
                          Text("Categories :", style: TextStyle(color: primaryBlue),),
                          SizedBox(height: 5,),
                          Text("Date :", style: TextStyle(color: primaryBlue),),
                          SizedBox(height: 5,),
                          Text("Type :", style: TextStyle(color: primaryBlue),),
                        ],
                      ),

                      SizedBox(width: 30,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.publication.title,),
                          SizedBox(height: 5,),
                          Text(widget.publication.category),
                          SizedBox(height: 5,),
                          Text(widget.publication.date,),
                          SizedBox(height: 5,),
                          Text(widget.publication.type.toUpperCase(),),
                        ],
                      ),
                    ],
                  ),
                ),

                Divider(color: darkGrey,indent: 5,endIndent: 5,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Description :", style: TextStyle(color: primaryBlue),),
                      SizedBox(height: 10,),
                      Text(widget.publication.description),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),

                Divider(color: darkGrey,indent: 5,endIndent: 5,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: primaryBlue,),
                          SizedBox(width: 10,),
                          Text( location ),

                        ],
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.4,

                        child: MapScreen(select: false,lat: lat, long:long, latCenter: lat, longCenter: long,)
                    ),
                  ],
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}



