import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/registerUserModel.dart';
import 'package:lostandfound/services/image_picker.dart';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;
var registerService = RegisterService();
//photo
ImagePickerService _imagePickerService = ImagePickerService();
File? _photo;

gettingUser() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var id = prefs.getString("_id");
  var user = await registerService.findRegistredUser(id!);
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
    //the user
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
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    user = snapshot.data as RegisterUser?;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: primaryGrey,
                              radius: 80,
                              child: _photo == null
                                  ? Icon(Icons.account_circle_rounded,
                                  size: 70,
                                  color: primaryBackground)
                                  : Stack(
                                children: [
                                  ClipOval(
                                    child: Image.file(
                                      _photo!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 10,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _photo = null;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: TextButton.icon(
                                onPressed: () async {
                                  var _image = await _imagePickerService
                                      .getPhotoFromGallery();
                                  if (_image != null) {
                                    setState(() {
                                      if (_photo != null) {
                                        _image = _photo;
                                        // _images.forEach((e) {
                                        //   _photos.add(e);
                                        // });
                                      } else {
                                        _photo = _image;
                                      }
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: primaryBackground,
                                ),
                                label: Text(""),
                              ),
                            ),
                          ],
                        ),



                        UserInfo("Nom", 20, primaryGrey),
                        UserInfo(user!.lastName, 25, Colors.black),
                        SizedBox(height: 15,),
                        UserInfo("Prénom", 20, primaryGrey),
                        UserInfo(user!.firstName, 25, Colors.black),
                        SizedBox(height: 15,),
                        UserInfo("Email", 20, primaryGrey),
                        UserInfo(user!.email, 25, Colors.black),
                        SizedBox(height: 15,),
                        UserInfo("Téléphone", 20, primaryGrey),
                        UserInfo(user!.phone, 25, Colors.black),
                        //text and link to my publications
                        //toggle for activating notifications
                        //button to modify info
                        ],
                    );
                  }else {
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

Widget UserInfo (String label, double size, Color color){
  return Text(label, style: TextStyle(
    color: color,
    fontSize: size,
  ),);
}
