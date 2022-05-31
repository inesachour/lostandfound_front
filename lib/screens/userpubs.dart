// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/widgets/mypub_card.dart';
import 'package:lostandfound/widgets/painter.dart';
import 'package:lostandfound/settings/config.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:provider/provider.dart';

class UserPubs extends StatefulWidget {
  const UserPubs({Key? key}) : super(key: key);

  @override
  _UserPubsState createState() => _UserPubsState();
}

class _UserPubsState extends State<UserPubs> {
  List<Publication> _pubs = [];
  var pubsStream = PubServices.getMyPubs();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Mes publications"),
          centerTitle: true,
          backgroundColor: primaryBlue,
          toolbarHeight: context.height * 0.12,
        ),
        body: Column(
          children: [
            /*CustomPaint(
              child: SizedBox(
                  width: context.width,
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mes publications",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  )),
              painter: CurvePainter(),
            ),*/
            SizedBox(
              height: context.height * .02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: FutureBuilder<List<Publication>>(
                future: pubsStream,
                //PubServices.getFoundPub(),
                // function where you call your api
                builder: (BuildContext context,
                    AsyncSnapshot<List<Publication>> snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('Chargement des données...'));
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      _pubs = snapshot.data != null ? snapshot.data!.reversed.toList() : [];
                    }
                    return SizedBox(
                      height: context.height * 0.7,
                      child: ListView.builder(
                          itemCount: _pubs.length,
                          itemBuilder: (context, index) {
                            Publication publication = _pubs[index];
                            return MyPubCard(publication,onDelete: ( val ){
                              if(val)
                              {
                                setState(() {
                                  pubsStream = PubServices.getMyPubs();
                                });
                              }
                            },);
                          }),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
