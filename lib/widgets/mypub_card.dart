// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/services/comments_service.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/settings/config.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/comment_widgets.dart';
import 'package:lostandfound/widgets/form_widgets.dart';
import 'package:lostandfound/widgets/update_pub_field.dart';

class MyPubCard extends StatefulWidget {
  MyPubCard(this._publication, {required this.onDelete});

  Publication _publication;
  void Function(bool) onDelete;

  @override
  _MyPubCardState createState() => _MyPubCardState();
}

class _MyPubCardState extends State<MyPubCard> {
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
    GeoCode geoCode = GeoCode();
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
    });
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
                    topRight: Radius.circular(20),
                    bottomLeft:
                    addCommentToggle ? Radius.zero : Radius.circular(20),
                    bottomRight:
                    addCommentToggle ? Radius.zero : Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 275,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.black54, width: 0.3)),
                        child: widget._publication.images.isNotEmpty
                            ? Image.memory(
                          Base64Decoder()
                              .convert(widget._publication.images[0].url),
                          fit: BoxFit.cover,
                        )
                            : Image.asset('assets/logo.png'),
                      ),
                      SizedBox(
                        height: 275,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.all(5),
                              color: Colors.black54,
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
                                        _locality ?? "",
                                        style: TextStyle(
                                          //fontSize: context.width * 0.035,
                                            color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Text(
                                          _adminArea != null
                                              ? ", " + _adminArea! + "  "
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
                                        "  " +
                                            widget._publication.date.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: addCommentToggle
                                          ? Colors.blue.shade300
                                          : Colors.black54,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          addCommentToggle = !addCommentToggle;
                                          CommentsService.getCommentService
                                              .findComments(
                                              publicationId:
                                              widget._publication.id!);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add_comment,
                                        color: Colors.white,
                                      )),
                                ),
                                Container(
                                    margin:
                                    EdgeInsets.only(right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: PopupMenuButton(
                                        icon: Icon(Icons.more_horiz_rounded,
                                            color: Colors.white),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: Text("Modifier"),
                                            value: 1,
                                            onTap: () async {
                                              print("tapped");
                                              Future.delayed(
                                                  const Duration(
                                                      seconds: 0),
                                                      () => showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                          AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(32.0))),
                                                            contentPadding:
                                                            EdgeInsets
                                                                .all(0),
                                                            content:
                                                            Container(
                                                              height: context
                                                                  .height *
                                                                  0.45,
                                                              child: SingleChildScrollView(
                                                                child: Padding(
                                                                    padding: const EdgeInsets.all(16.0),
                                                                    child: Column(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            UpdatePubField(
                                                                              "Title",
                                                                              widget._publication.title,
                                                                              getContent: (val) {
                                                                                setState(() {
                                                                                  widget._publication.title = val;
                                                                                });
                                                                              },
                                                                            ),
                                                                            UpdatePubField(
                                                                              "Description",
                                                                              widget._publication.description,
                                                                              getContent: (val) {
                                                                                setState(() {
                                                                                  widget._publication.description = val;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              decoration:BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: Colors.grey.withOpacity(0.2),
                                                                                    spreadRadius: 3,
                                                                                    blurRadius: 5,
                                                                                    offset: Offset(0, 3), // changes position of shadow
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              child: IconButton(
                                                                                onPressed: () async {
                                                                                  await PubServices.updatePub(widget._publication.id!, widget._publication.title, widget._publication.description).then((value) {
                                                                                    Navigator.of(context).pop();
                                                                                  });
                                                                                },
                                                                                icon: Icon(Icons.check,color: Colors.blue.shade300,),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )),
                                                              ),
                                                              decoration:
                                                              BoxDecoration(
                                                                gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                      Colors.blue.shade200,
                                                                      Colors.blue.shade100
                                                                    ]),
                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(32.0)),
                                                              ),
                                                            ),
                                                          )));
                                            },
                                          ),
                                          PopupMenuItem(
                                              child: Text("Supprimer"),
                                              value: 2,
                                              onTap: () {
                                                PubServices.deletePub(widget
                                                    ._publication.id!)
                                                    .then((value) {
                                                  widget.onDelete(true);
                                                });
                                              })
                                        ])),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  color: Colors.black54,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget._publication.title,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget._publication.description,
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              //padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  // color: Colors.grey.shade300,
                  color: Colors.grey.shade200),
              child: Column(children: [
                /*Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                ),*/
                addCommentToggle
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: listComments(context,
                      controller: commentController,
                      publicationId: widget._publication.id!),
                )
                    : SizedBox(),
              ])),
        ],
      ),
    );
  }
}
