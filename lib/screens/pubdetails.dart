import 'package:flutter/material.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:lostandfound/settings/colors.dart';
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

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.red,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                color: Colors.white,
              ),
            ],
          ),

          Positioned(
            top: 25,
            child: Icon(Icons.arrow_back),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height * 0.76,
            width: MediaQuery.of(context).size.width*0.8,
            top: MediaQuery.of(context).size.height * 0.22,
            left: MediaQuery.of(context).size.width*0.1,
            child: PublicationDetailsCard(publication: widget.publication),
          ),
        ],
      ),
    );
  }
}
