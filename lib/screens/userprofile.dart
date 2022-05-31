import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/registerUserModel.dart';
import 'package:lostandfound/screens/modifprofile.dart';
import 'package:lostandfound/screens/premiumpurchase.dart';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;
var registerService = RegisterService();
bool isSwitched = false;



class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //the user future

  var _userFuture = gettingUser();


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        FutureBuilder(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              user = snapshot.data as RegisterUser?;
              var username = user!.firstName.toUpperCase() +
                  " " +
                  user!.lastName.toUpperCase();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TODO upper part ui fix
                  Container(

                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.28,
                    margin: const EdgeInsets.only(bottom: 20),
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 60),
                          color: primaryBlue,
                          //height: MediaQuery.of(context).size.height * 0.23,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: UserInfo(username, 23, Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white,),
                            tooltip: 'Modifier votre profile',
                            onPressed: () async {
                              /***********modification screen*********/
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ModifProfile()),
                              ).then((value) {
                                setState(() {
                                  _userFuture = gettingUser();
                                });
                              });
                            },
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.35,
                          top: MediaQuery.of(context).size.height * 0.1,
                          child: CircleAvatar(
                            backgroundColor: primaryGrey,
                            radius: MediaQuery.of(context).size.width * 0.15,
                            child: user!.photo == null
                                ? Icon(Icons.account_circle_rounded,
                                size: 70, color: primaryBackground)
                                : ClipOval(
                              child: Image.memory(
                                Base64Decoder()
                                    .convert(user!.photo.url),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        InkWell(
                          child: Row(
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
                          onTap: (){
                            Navigator.pushNamed(context, '/userpubs');
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        Divider(
                          thickness: 0.7,
                          color: primaryGrey,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //switch for activating notifications
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.notification_important_outlined,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "Notifications",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              flex: 10,
                            ),
                            Expanded(
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    //isSwitched = value;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumPurchase()));
                                    // print(isSwitched);
                                  });
                                },
                                activeTrackColor: Colors.lightBlueAccent,
                                activeColor: primaryBlue,
                              ),
                            ),
                          ],
                        ),
                        // ElevatedButton(
                        //   child: Text(
                        //     "Modifier vos informations",
                        //     style:
                        //         TextStyle(color: primaryBlue, fontSize: 15),
                        //   ),
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(
                        //       Colors.white,
                        //     ),
                        //     shape: MaterialStateProperty.all(
                        //         RoundedRectangleBorder(
                        //             borderRadius:
                        //                 BorderRadius.circular(20))),
                        //     fixedSize: MaterialStateProperty.all(
                        //         Size(width * 0.9, 50)),
                        //   ),
                        //   onPressed: () {
                        //     /***********modification screen*********/
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ModifProfile()),
                        //     );
                        //   },
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          child: Container(
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.star ),
                              label: Text("Premimum", style: TextStyle(fontSize: 16),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                shadowColor: MaterialStateProperty.all(Colors.transparent),
                                elevation: MaterialStateProperty.all(0)
                              ),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumPurchase()));
                              },
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.07,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  //Color(0xffB78628),
                                  //Color(0xffC69320),
                                  Color(0xffDBA514),
                                  Color(0xffEEB609),
                                  Color(0xffFCC201),
                                ]
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
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

gettingUser() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var id = prefs.getString("userId");
  print(id!);
  var user = await registerService.findRegistredUser(id);
  print(user!.firstName);
  return user;
}