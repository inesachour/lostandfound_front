import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/map.dart';

class PublicationDetailsCard extends StatefulWidget {
  PublicationDetailsCard({required this.publication});

  Publication publication;

  @override
  State<PublicationDetailsCard> createState() => _PublicationDetailsCardState();
}

class _PublicationDetailsCardState extends State<PublicationDetailsCard> {



  @override
  Widget build(BuildContext context) {

    double lat = double.parse(widget.publication.location.coordinates[0]);
    double long = double.parse(widget.publication.location.coordinates[1]);

    return Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Colors.white,
          border: Border.all(
            color: primaryGrey
          ),
      ),
      child: Column(
        children: [

          SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(
                  icon: Icon(Icons.message, color: primaryGrey,),
                  onPressed: (){

                  }
              ),

              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryGrey,
                    radius: MediaQuery.of(context).size.width * 0.05,
                    child: widget.publication.owner.photo == ""
                        ? Icon(Icons.account_circle_rounded,
                        size: 40, color: primaryBackground)
                        : ClipOval(
                      child: Image.memory(
                        Base64Decoder().convert(widget.publication.owner.photo),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    widget.publication.owner.firstName+ " "+ widget.publication.owner.lastName,
                    style: TextStyle(color: primaryGrey),
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.mail, color: primaryGrey),
                  onPressed: (){

                  }
              ),
            ],
          ),
          Divider(color: Colors.black,indent: 5,endIndent: 5,),


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

                Divider(color: Colors.black,indent: 5,endIndent: 5,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Description :", style: TextStyle(color: primaryBlue),),
                      SizedBox(height: 10,),
                      Text(widget.publication.description),
                    ],
                  ),
                ),

                Divider(color: Colors.black,indent: 5,endIndent: 5,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: primaryBlue,),
                          SizedBox(width: 10,),
                          Text( "fix"),

                        ],
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                        width: MediaQuery.of(context).size.width*0.8,
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

