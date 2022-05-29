
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/screens/pubdetails.dart';
import 'package:lostandfound/services/comments_service.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/settings/config.dart';
import 'package:lostandfound/widgets/comment_widgets.dart';


class Pubcard extends StatefulWidget {
  Pubcard(this._publication);

  Publication _publication;

  @override
  State<Pubcard> createState() => _PubcardState();
}

class _PubcardState extends State<Pubcard> {
  bool disposed = false;
  String? _locality;
  String? _adminArea;
  bool addCommentToggle = false;
  TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    /*GeoCode geoCode = GeoCode();
    geoCode
        .reverseGeocoding(
            latitude: double.parse(widget._publication.location.coordinates[0]),
            longitude:
                double.parse(widget._publication.location.coordinates[1]))
        .then((value) {
      if (!disposed) {
        setState(() {
          _locality = value.city; // value[0].locality.toString();
          _adminArea = value.region; //[0].adminArea.toString();
        });
      }
    });*/

    final coordinates = new Coordinates(
        double.parse(widget._publication.location.coordinates[0]),
        double.parse(widget._publication.location.coordinates[1])
    );
    Geocoder.local.findAddressesFromCoordinates(coordinates).then((c) {
      setState(() {
        _locality = c.first.subAdminArea ?? "";
        _adminArea = c.first.adminArea ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        String id = widget._publication.id!;
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PublicationDetails(publication: widget._publication))
        );
      },
      child: Container(
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
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: widget._publication.images.length != 0
                              ? Image.memory(
                                  Base64Decoder()
                                      .convert(widget._publication.images[0].url),
                                  fit: BoxFit.cover,
                                  //image: NetworkImage(widget._publication.images[0].url),
                                )
                              : Image.asset('assets/logo.png'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.all(5),
                          color: Colors.black26,
                          child: Column(
                            children: [
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
                                  Text(
                                    _locality != null && _locality != "" ? _locality! + ", " : "",
                                    style: TextStyle(
                                        //fontSize: context.width * 0.035,
                                        color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _adminArea != null
                                          ? " " + _adminArea! + "  "
                                          : "",
                                      style: TextStyle(
                                          //fontSize: context.width * 0.035,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "  " + widget._publication.date.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    // color: Colors.grey.shade300,
                    color: Colors.grey.shade200),
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
                              radius: 22,
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.transparent,
                                radius: 28,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              widget._publication.owner.firstName + "\n" + widget._publication.owner.lastName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey,
                              ),
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
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                                Icon(Icons.message, size: context.width * 0.06),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey.shade400),
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
                                Icon(
                                  Icons.add_comment,
                                  size: context.width * 0.06,
                                ),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  addCommentToggle
                                      ? primaryBlue
                                      : Colors.grey.shade400),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ))),
                          onPressed: () {
                            setState(() {
                              addCommentToggle = !addCommentToggle;
                              CommentsService.getCommentService.findComments(
                                  publicationId: widget._publication.id!);
                            });
                          }),
                    ],
                  ),
                  addCommentToggle
                      ? listComments(
                            context,
                              controller: commentController,
                              publicationId: widget._publication.id!)
                      : SizedBox(),
                ])),
          ],
        ),
      ),
    );
  }
}
