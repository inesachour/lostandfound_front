// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/widgets/pubcard.dart';
import 'package:lostandfound/widgets/searchbar.dart';

class Consultpubs extends StatefulWidget {
  @override
  _ConsultpubsState createState() => _ConsultpubsState();
}

class _ConsultpubsState extends State<Consultpubs> {
  TextEditingController textController = TextEditingController();
  List<Publication> _pubs=[];

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.shade300,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.88,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: NestedScrollView(
                        headerSliverBuilder: (context, value) {
                          return [
                            SliverAppBar(
                              pinned: true,
                              backgroundColor: Colors.grey.shade200,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              toolbarHeight: 0,
                              bottom: TabBar(
                                labelColor: Colors.blue.shade300,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.blue.shade300,
                                tabs: [
                                  Tab(text: 'Lost'),
                                  Tab(text: 'Found'),
                                ],
                              ),
                            )
                          ];
                        },
                        body: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Searchbar(),
                                      InkWell(
                                          splashColor: Colors.blue,
                                          child: Text(
                                            'Filtrer',
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                color: Colors.grey.shade400),
                                          ),
                                          onTap: () {
                                            print("filtrer");
                                          }),
                                    ],
                                  ),
                                  for(int i = 0, len =(_pubs = PubServices.getLostPub()).length;i<len;i++)
                                    Pubcard(_pubs[i]),

                                  SizedBox(height: MediaQuery.of(context).size.height*0.1,)
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Searchbar(),
                                      InkWell(
                                          splashColor: Colors.blue,
                                          child: Text(
                                            'Filtrer',
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                color: Colors.grey.shade400),
                                          ),
                                          onTap: () {
                                            print("filtrer");
                                          }),
                                    ],
                                  ),
                                  for(int i = 0, len =(_pubs = PubServices.getFoundPub()).length;i<len;i++)
                                    Pubcard(_pubs[i]),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.1,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      );
  }
}
