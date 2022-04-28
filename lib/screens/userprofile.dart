import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/registerUserModel.dart';
import 'package:lostandfound/screens/modifprofile.dart';
import 'package:lostandfound/services/image_picker.dart';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;
var registerService = RegisterService();
bool isSwitched = false;

gettingUser() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var id = prefs.getString("_id");
  var user = await registerService.findRegistredUser(id!);
  print(user!.firstName);
  return user;
}

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    //the user future
    late Future<dynamic> _userFuture = gettingUser();

    //Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    user = snapshot.data as RegisterUser?;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //abt this profile pic stack, can do a container, than has the name and image of the person shit
                        //gotta do some research abt profile screens
                        //just show it now
                        Center(
                          child: CircleAvatar(
                            backgroundColor: primaryGrey,
                            radius: 60,
                            child: user!.photo == null
                                ? Icon(Icons.account_circle_rounded,
                                    size: 70, color: primaryBackground)
                                : ClipOval(
                                    child: Image.memory(
                                      Base64Decoder().convert(user!.photo.url),
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),

                        UserInfo("Nom", 20, primaryGrey),
                        UserInfo(user!.lastName, 25, Colors.black),
                        SizedBox(
                          height: 15,
                        ),
                        UserInfo("Prénom", 20, primaryGrey),
                        UserInfo(user!.firstName, 25, Colors.black),
                        SizedBox(
                          height: 15,
                        ),
                        UserInfo("Email", 20, primaryGrey),
                        UserInfo(user!.email, 25, Colors.black),
                        SizedBox(
                          height: 15,
                        ),
                        UserInfo("Téléphone", 20, primaryGrey),
                        UserInfo(user!.phone, 25, Colors.black),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 0.7,
                          color: primaryGrey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mes publications",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: primaryBlue),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mes commentaires",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: primaryBlue),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 0.7,
                          color: primaryGrey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //toggle for activating notifications
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Icon(Icons.notification_important_outlined),),
                            SizedBox(width: 5,),
                            Expanded(child: Text("Notifications",style: TextStyle(
                              fontSize: 20,
                            ),),flex: 10,),
                            Expanded(
                              child: Switch(value: isSwitched,
                                onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  print(isSwitched);
                                });
                              },
                                activeTrackColor: Colors.lightBlueAccent,
                                activeColor: primaryBlue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          child: Text("Modifier vos informations", style: TextStyle(color: primaryBlue, fontSize: 15),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            fixedSize: MaterialStateProperty.all(
                                Size(width * 0.9, 50)),
                          ),
                          onPressed: () {
                            /***********modification screen*********/
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ModifProfile()),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget UserInfo(String label, double size, Color color) {
  return Text(
    label,
    style: TextStyle(
      color: color,
      fontSize: size,
    ),
  );
}
