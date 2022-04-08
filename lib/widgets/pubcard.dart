import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/settings/config.dart';

class Pubcard extends StatefulWidget {
  Pubcard(this._publication);

  Publication _publication;

  @override
  State<Pubcard> createState() => _PubcardState();
}

class _PubcardState extends State<Pubcard> {
  TextOverflow _overflow = TextOverflow.ellipsis;

  String _show = "voir plus";
  String? _locality;
  String? _adminArea;

  @override
  void initState() {
    super.initState();

    GeoCode geoCode = GeoCode();
    geoCode.reverseGeocoding(
        latitude: double.parse(widget._publication.location.coordinates[0]),
        longitude: double.parse(widget._publication.location.coordinates[1])
        ).then((value) {
     setState(() {
        _locality = value.city.toString();// value[0].locality.toString();
        _adminArea = value.region.toString(); //[0].adminArea.toString();
     });
    });
    /*Geocoder.local
        .findAddressesFromCoordinates(Coordinates(
           double.parse(widget._publication.location.coordinates[0]),
        double.parse(widget._publication.location.coordinates[1])))
        .then((value) {
      setState(() {
        _locality = value[0].locality.toString();
        _adminArea = value[0].adminArea.toString();
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.9,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            fit: StackFit.passthrough,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height*0.06,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "  "+widget._publication.date.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: context.height * 0.01,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(
                                  height: context.height * 0.01,
                                ),
                                Container(
                                  child: Text(
                                    _locality ?? "",
                                    style: TextStyle(
                                        fontSize: context.width * 0.035,
                                        color: Colors.white
                                    ),

                                  ),
                                ),
                                Container(
                                  child: Text(
                                    _adminArea != null ? ", "+_adminArea!+ "  " :"",
                                    style: TextStyle(
                                        fontSize: context.width * 0.035,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold

                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: widget._publication.images.length != 0 ?
                        Image.memory(
                          Base64Decoder().convert(widget._publication.images[0].url),
                          fit: BoxFit.cover,
                          //image: NetworkImage(widget._publication.images[0].url),
                        ) : Image.asset('assets/logo.png'),
                      ),
                    ],
                  )),
              Padding(
                padding:EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Text(
                      widget._publication.date.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    InkWell(
                        onTap: () {
                          print("amal");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              height: context.height * 0.01,
                            ),
                            Container(
                              child: Text(
                                _locality?.replaceAll(" ", "\n") ?? "",
                                style: TextStyle(
                                    fontSize: context.width * 0.035,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                _adminArea ?? "",
                                style: TextStyle(
                                    fontSize: context.width * 0.035,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ))*/
                  ],
                ),
              )
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.grey.shade300,
              ),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                            child: CircleAvatar(
                              child: Icon(Icons.person, size: 40,color: Colors.white,),
                              backgroundColor: Colors.transparent,
                              radius: 28,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Text(
                            widget._publication.owner.firstName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget._publication.title,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget._publication.description,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                overflow: _overflow,
                              ),
                              SizedBox(height: 5,),
                              InkWell(
                                onTap: () {
                                  if (_show == "voir plus") {
                                    setState(() {
                                      _show = "voir moins";
                                      _overflow = TextOverflow.clip;
                                    });
                                  } else {
                                    {
                                      setState(() {
                                        _show = "voir plus";
                                        _overflow = TextOverflow.ellipsis;
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  _show,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: Container(
                          width: context.width * 0.3,
                          padding: EdgeInsets.all(context.width * 0.01),
                          child: Row(
                            children: [
                              Icon(Icons.message,size: context.width*0.06),
                              SizedBox(
                                width: context.width * 0.02,
                              ),
                              Text(
                                "Envoyer un\nmessage",
                                style:
                                    TextStyle(fontSize: context.width * 0.03),
                              )
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey.shade400),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ))),
                        onPressed: () {}),
                    ElevatedButton(
                        child: Container(
                          width: context.width * 0.3,
                          padding: EdgeInsets.all(context.width * 0.01),
                          child: Row(
                            children: [
                              Icon(Icons.add_comment,size: context.width*0.06,),
                              SizedBox(
                                width: context.width * 0.02,
                              ),
                              Text(
                                "ajouter un\ncommentaire",
                                style:
                                    TextStyle(fontSize: context.width * 0.03),
                              )
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey.shade400),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ))),
                        onPressed: () {}),
                  ],
                ),
              ])),
        ],
      ),
    );
  }
}
