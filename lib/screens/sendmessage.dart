// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/chat_message.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/models/userProf.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/settings/const.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

class SendMessage extends StatefulWidget {
  User user;

  SendMessage({required this.user});

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  ///variables zone !!
  bool disposed = false;
  final ScrollController _scrollController = ScrollController();
  var _controller = TextEditingController();
  late String myID;
  late List messages = [];
  UserProfile? user;
  IO.Socket socket = IO.io(Const.url,
      IO.OptionBuilder()
      .setTransports(['websocket'])
          .build());

  ///functions zone !!!
  void connectAndListen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    myID = prefs.getString("userId")!;

    socket.emit('signin', {"myID": myID, "otherID": widget.user.id});

    socket.onConnect((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    socket.on('newChat', (data) {
      if (!disposed && data != null) {
        setState(() {
          messages.add(ChatMessage(
              messageContent: data["message"],
              messageType: (data["sender"] == myID) ? "sender" : "receiver"));
        });
      }
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    socket.on('allChats', (data) {
      var _data = jsonDecode(data);
      if (!disposed) {
        setState(() {
          messages.clear();
        });
      }
      for (int i = 0; i < _data.length && !disposed; i++) {
        setState(() {
          messages.add(ChatMessage(
              messageContent: _data[i]["message"],
              messageType:
                  (_data[i]["sender"] == myID) ? "sender" : "receiver"));
        });
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      }
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  _sendMessage() {
      socket.emit('chat', {
      "message": _controller.text,
      "sender": myID,
      "recipient": widget.user.id,
      "time":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"
    });

    if (!disposed && myID != widget.user.id) {
      setState(() {
        messages.add(ChatMessage(
            messageContent: _controller.text, messageType: "sender"));
      });
    }
    _controller.clear();
  }

  @override
  void initState() {
    connectAndListen();
    _controller = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    setState(() {
      disposed = true;
    });
    super.dispose();
  }

  ///end Zones




  @override
  Widget build(BuildContext context)
  {
    UsersService.findUserProfile(userId: widget.user.id!).then((value) {
      if(user==null){
        if(mounted){
          setState(() {
            user=value;
          });
        }

      }
    }
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title:
          Row(
            children: [
              CircleAvatar(
                backgroundColor: darkGrey,
                radius: MediaQuery.of(context).size.width * 0.05,
                child: user == null || user?.photo == null
                    ? Icon(Icons.account_circle_rounded,
                    color: primaryBackground)
                    : ClipOval(
                  child: Image.memory(
                    Base64Decoder().convert(user!.photo!.url),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text(
                //widget.publication.owner.firstName+ " "+ widget.publication.owner.lastName,
                user != null && user!.firstName != null ? user!.firstName! + " " + user!.lastName! : "",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    /*GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),*/
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _sendMessage();
                        }
                        if (_scrollController.hasClients) {
                          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.lightBlueAccent.shade400,
                      elevation: 1,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
