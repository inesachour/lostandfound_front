import 'package:flutter/material.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/services/pubservices.dart';

class PublicationDetails extends StatefulWidget {
  PublicationDetails({Key? key, required this.id }) : super(key: key);

  String id;

  @override
  _PublicationDetailsState createState() => _PublicationDetailsState();
}

class _PublicationDetailsState extends State<PublicationDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                color: Colors.red,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                color: Colors.blue,
              ),
            ],
          ),

          Positioned(
            top: 25,
            child: Icon(Icons.arrow_back),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
