import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/models/userProf.dart';
import 'package:lostandfound/settings/colors.dart';

class MessageCard extends StatefulWidget {
  MessageCard({Key? key, required this.user, required this.lastMessage,required this.date,required this.getState})
      : super(key: key);
  UserProfile user;
  String lastMessage;
  String date;

  void Function(bool) getState;

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/sendMessage",
            arguments: User(
              photo: '',
              lastName: "",
              firstName: "",
              id: widget.user.id,
              email: '',
              phone: '',
            )).then((value) {
              setState(() {
                widget.getState(true);
              });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: primaryGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: darkGrey,
                  radius: MediaQuery.of(context).size.width * 0.07,
                  child: widget.user.photo == null
                      ? Icon(
                          Icons.account_circle_rounded,
                          color: primaryBackground,
                          size: 45,
                        )
                      : ClipOval(
                          child: Image.memory(
                            Base64Decoder().convert(widget.user.photo!.url),
                            width: 50,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.firstName! + " " + widget.user.lastName!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.lastMessage),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${DateTime.parse(widget.date).day}-${DateTime.parse(widget.date).month}"),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(Icons.more_horiz),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
