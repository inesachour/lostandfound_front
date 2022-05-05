// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/widgets/filter_popup.dart';
import 'package:lostandfound/services/auth_services.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/pubcard.dart';
import 'package:lostandfound/widgets/searchBar.dart';
import 'package:lostandfound/settings/config.dart';

class Consultpubs extends StatefulWidget {
  @override
  _ConsultpubsState createState() => _ConsultpubsState();
}

class _ConsultpubsState extends State<Consultpubs> {
  TextEditingController textController = TextEditingController();
  List<Publication> _pubs = [];
  var pubsStreamLost = PubServices.getLostPub();
  var pubsStreamFound = PubServices.getFoundPub();
  bool filterActivatedFound = false;
  bool filterActivatedLost = false;

  @override
  Widget build(BuildContext context) {

    _show(String type) async {
      var pubs = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
                child: Container(
                    height: MediaQuery.of(context).size.height*0.8,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FilterPopUp(type: type)
                )
            );
          }
      );

      setState(() {

        if(pubs != null){
          if(pubs[0] == "Lost"){
            pubsStreamLost = pubs[1];
            filterActivatedLost = true;

          }
          else if(pubs[0]== "Found"){
            pubsStreamFound = pubs[1];
            filterActivatedFound= true;
          }
        }

      });
    }

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: IconButton(
            alignment: Alignment.topRight,
            icon:Icon(Icons.logout,color: Colors.white,semanticLabel: "Logout",),
            onPressed: (){
              Auth.Logout().then((value) {
                Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
              });
            },
          ),
          color: primaryBlue
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
                            backgroundColor: primaryBackground,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            toolbarHeight: 0,
                            bottom: TabBar(
                              labelColor: primaryBlue,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: primaryBlue,
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
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SearchBar(),

                                  Row(
                                    children: [
                                      InkWell(
                                          splashColor: primaryBlue,
                                          child: Text(
                                            'Filtrer',
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                color: Colors.grey.shade400),
                                          ),
                                          onTap: () {
                                            _show("Lost");
                                            /*showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                  _show("Lost");//return FilterPopUp(type: "Lost");
                                                }
                                            );*/
                                          }),

                                      filterActivatedLost ? IconButton(
                                        icon: Icon(Icons.cancel_rounded),
                                        color: Colors.red,
                                        onPressed: (){
                                          setState(() {
                                            pubsStreamLost = PubServices.getLostPub();
                                            filterActivatedLost = false;
                                          });
                                        },
                                      ) : SizedBox(),
                                    ],
                                  ),

                                ],
                              ),
                              FutureBuilder<List<Publication>>(
                                future: pubsStreamLost,//PubServices.getLostPub(),
                                // function where you call your api
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Publication>> snapshot) {
                                  // AsyncSnapshot<Your object type>
                                  // AsyncSnapshot<Your object type>
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child:
                                            Text('Please wait its loading...'));
                                  } else {
                                    if (snapshot.hasError)
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    else
                                      _pubs = snapshot.data ?? [];
                                    return Container(
                                      height: context.height * 0.69,
                                      child: ListView.builder(
                                          itemCount: _pubs.length,
                                          itemBuilder: (context, index) {
                                            Publication publication =
                                                _pubs[index];
                                            return Pubcard(publication);
                                          }),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SearchBar(),

                                  Row(
                                    children: [
                                      InkWell(
                                          splashColor: primaryBlue,
                                          child: Text(
                                            'Filtrer',
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                color: Colors.grey.shade400),
                                          ),
                                          onTap: () {
                                            _show("Lost");
                                            /*showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                  _show("Lost");//return FilterPopUp(type: "Lost");
                                                }
                                            );*/
                                          }),

                                      filterActivatedFound ? IconButton(
                                        icon: Icon(Icons.cancel_rounded),
                                        color: Colors.red,
                                        onPressed: (){
                                          setState(() {
                                            pubsStreamFound = PubServices.getFoundPub();
                                            filterActivatedFound = false;
                                          });
                                        },
                                      ): SizedBox(),
                                    ],
                                  ),

                                ],
                              ),
                              FutureBuilder<List<Publication>>(
                                future: pubsStreamFound,//PubServices.getFoundPub(),
                                // function where you call your api
                                builder: (BuildContext context, AsyncSnapshot<List<Publication>> snapshot) {
                                  // AsyncSnapshot<Your object type>
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child:
                                            Text('Please wait its loading...'));
                                  } else {
                                    if (snapshot.hasError)
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    else
                                      _pubs = snapshot.data ?? [];
                                    return Container(
                                      height: context.height * 0.69,
                                      child: ListView.builder(
                                          itemCount: _pubs.length,
                                          itemBuilder: (context, index) {
                                            Publication publication =
                                                _pubs[index];
                                            return Pubcard(publication);
                                          }),
                                    );
                                  }
                                },
                              ),
                            ],
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
