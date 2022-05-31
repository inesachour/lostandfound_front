import 'package:flutter/material.dart';
import 'package:lostandfound/models/chat_message.dart';
import 'package:lostandfound/models/userProf.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/message_card.dart';


class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  var messages ;//TODO AJOUTER = Service.methode()
  List<ChatMessage> _msgs = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [

            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.12,
                  color: primaryBlue,
                ),
                Positioned(
                    child: Padding(
                      padding: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.04),
                      child: Center(
                          child: Text(
                            "Messages",
                            style: TextStyle(fontSize: 24,color: Colors.white),
                          )
                      ),
                    ),
                ),
                Positioned(
                  right: 20,
                  top: MediaQuery.of(context).size.height*0.039,
                  child: Icon(Icons.add, size: 35,color: Colors.white,),
                )
              ]
            ),

            FutureBuilder<List<ChatMessage>>(
              future: messages,
              // function where you call your api
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatMessage>> snapshot) {
                // AsyncSnapshot<Your object type>
                // AsyncSnapshot<Your object type>
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child:
                      Text('chargement des données...'));
                } else {
                  if (snapshot.hasError)
                    return Center(
                        child:
                        Text('Error: ${snapshot.error}'));
                  else
                    _msgs = snapshot.data != null ? snapshot.data!.reversed.toList() : [];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 1),

                    height: MediaQuery.of(context).size.height*0.7,
                    child: ListView.builder(
                        itemCount:_msgs.length,
                        itemBuilder: (context, index) {
                          return MessageCard( //TODO remplacer user et last message
                            lastMessage: "test",
                            user: UserProfile(
                              firstName: "first",
                              lastName: "last",
                              role: "user",
                              verified: true
                            ),
                          );
                        }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
