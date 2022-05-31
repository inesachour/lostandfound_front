import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/image.dart' as img;
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/models/userProf.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/message_card.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var messages=[]; //TODO AJOUTER = Service.methode()
  late String myID;
  IO.Socket socket =
      IO.io(Const.url, IO.OptionBuilder().setTransports(['websocket']).build());

  bool disposed=false;

  void connectAndListen() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    myID = prefs.getString("userId")!;
    socket.emit("try",myID);

    socket.onConnect((_) {
      print("connected");
    });
    socket.onDisconnect((_) => print('disconnect'));

    socket.on('conversation', (data) {
      print("conversation");
      if(!disposed) {
        setState(() {
        messages = data;
        print(messages[0]);
      });
      }

    });
  }

  @override
  void initState() {
    connectAndListen();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      disposed=true;
    });
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                color: primaryBlue,
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Center(
                      child: Text(
                    "Messages",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )),
                ),
              ),
              Positioned(
                right: 20,
                top: MediaQuery.of(context).size.height * 0.039,
                child: Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.white,
                ),
              )
            ]),
            Container(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return MessageCard(
                            lastMessage: messages[index]["lastMsg"]["message"],
                            date: messages[index]["lastMsg"]["time"],
                            user: UserProfile(
                              id: messages[index]["otherUser"]["_id"],
                                photo:messages[index]["otherUser"]["photo"] != null ?img.Image.fromJson(messages[index]["otherUser"]["photo"]):null,
                                firstName: messages[index]["otherUser"]["firstName"],
                                lastName: messages[index]["otherUser"]["lastName"],
                                email: messages[index]["otherUser"]["email"],
                                phone: messages[index]["otherUser"]["phone"],
                                role: messages[index]["otherUser"]["role"],
                                verified: messages[index]["otherUser"]["verified"]
                            ),
                          );
                        }),
                  )

          ],
        ),
      ),
    );
  }
}
