import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:lostandfound/widgets/pub_details_card.dart';


class PublicationDetails extends StatefulWidget {
  PublicationDetails({Key? key, required this.publication }) : super(key: key);

  Publication publication;

  @override
  _PublicationDetailsState createState() => _PublicationDetailsState();
}

class _PublicationDetailsState extends State<PublicationDetails> {


  @override
  Widget build(BuildContext context){

    List images = [];
    List<Widget> imageIndactor = [];
    PageController pagesController = PageController(viewportFraction: 0.9);

    widget.publication.images.forEach((e) {
      images.add(Base64Decoder().convert(e.url));
    });


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: lightGrey,
                child: images.length >0 ? PageView.builder(
                    itemCount: images.length,
                    pageSnapping: true,
                    controller: pagesController,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            images[index],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    }) : Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.fitWidth
                ),

              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                color: lightGrey,
              ),
            ],
          ),

         /* Positioned(
            top: 25,
            left: 0,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back, color: primaryBlue,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),*/

          Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              child: Row(
                children: imageIndactor
              )
          ),

          Positioned(
            height: MediaQuery.of(context).size.height * 0.76,
            width: MediaQuery.of(context).size.width*0.9,
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width*0.05,
            child: PublicationDetailsCard(publication: widget.publication),
          ),
        ],
      ),
    );
  }
}
/*

imageIndactor.add(
Container(
width: 10.0,
height: 10.0,
margin: EdgeInsets.all(3),
decoration: new BoxDecoration(
color: primaryGrey,
shape: BoxShape.circle,
),
)
);*/
