import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/registerUserModel.dart';
import 'package:lostandfound/screens/register.dart';
import 'package:lostandfound/services/auth_services.dart';
import 'package:lostandfound/services/image_picker.dart';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/settings/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lostandfound/screens/userprofile.dart';

var user;
var registerService = RegisterService();
var usersService = UsersService();

var firstName;
var lastName;
var phone;
var email;
var password;

gettingUser() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var id = prefs.getString("userId");
  var user = await registerService.findRegistredUser(id!);

  return user;
}

class ModifProfile extends StatefulWidget {
  const ModifProfile({Key? key}) : super(key: key);

  @override
  _ModifProfileState createState() => _ModifProfileState();
}

class _ModifProfileState extends State<ModifProfile> {
  //Form Validation variables
  final _formKey = GlobalKey<FormState>();

  //show password control
  bool eyeForPassword = true;
  bool eyeForConfirmPassword = true;

  // validators
  var validator = (value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez remplir ce champ';
    }
    return null;
  };

  var passwordValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Resaisir le mot de passe';
    }
    if (value.toString().length < 6) {
      return 'longeur minimal de 6 caractères';
    }
    return null;
  };

  var emailValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'E-mail obligatoire';
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return 'Entrer une adresse valide';
    }
    return null;
  };

  var phoneValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Téléphone obligatoire';
    }
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{8}$)').hasMatch(value)) {
      return 'Entrer un numéro valide';
    }
    return null;
  };

  //photo
  ImagePickerService _imagePickerService = ImagePickerService();
  File? _photo;

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
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Text(
          "Modifier vos infos",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = snapshot.data as RegisterUser?;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
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
                          SizedBox(
                            height: 25,
                          ),
                          Field(text: user!.firstName,type: "name", hint: "Prénom", validator: validator,getContent: (value){
                            setState(() {
                              firstName = value;
                            });
                          },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Field(text: user!.lastName, type: "name", hint: "Nom",validator: validator, getContent: (value){
                            setState(() {
                              lastName = value;
                            });
                          },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Field(text: user!.phone,type: "phone", hint: "Tél",validator: phoneValidator, getContent: (value){
                            setState(() {
                              phone = value;
                            });
                          },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Field(text: user!.email, type: "email", hint: "Email",validator: emailValidator, getContent: (value){
                            setState(() {
                              email = value;
                            });
                          },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Field(type: "password", hint: "Mot de passe",getContent: (value){
                              setState(() {
                              password = value;
                              });
                              },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            child: Text(
                              "Valider",
                              style: TextStyle(fontSize: 15),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                primaryBlue,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              fixedSize: MaterialStateProperty.all(
                                  Size(width * 0.7, 50)),
                            ),
                            onPressed: () async {
                              final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                              final SharedPreferences prefs = await _prefs;
                              var _id = prefs.getString("userId");
                              print(_id);
                              var user = await registerService.findRegistredUser(_id!);

                              if (_formKey.currentState!.validate()) {
                                await usersService.updateUser(
                                  id: _id,
                                  firstName: firstName ?? user!.firstName,
                                  lastName: lastName ?? user!.lastName,
                                  phone: phone ?? user!.phone,
                                  email: email ?? user!.email,
                                  password: password ?? user!.password,
                                  photo: _photo,
                                  role: user.role,
                                  verified: user.verified,
                                );
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UserProfile()),
                                );*/
                                Navigator.pop(context,true);
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            child: Text(
                              "Supprimer votre compte",
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xfffafafa),
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              fixedSize: MaterialStateProperty.all(
                                  Size(width * 0.9, 50)),
                            ),
                            onPressed: () async {
                              final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                              final SharedPreferences prefs = await _prefs;
                              var _id = prefs.getString("_id");
                              var result = await usersService.deleteUser(id: _id) as bool;
                              if(result == true){
                                Auth.Logout().then((value) {
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil("/", (route) => false);
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height : 20,
                          ),
                        ],
                      ),
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
        ),
      ),
    );
  }
}

class Field extends StatefulWidget {
  String? text;
  String type;
  String hint;
  dynamic validator;
  void Function(String)? getContent;
  Field({ required this.type,required this.hint,this.getContent, this.text, this.validator});
  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  bool show = true;
  FocusNode _focusNode = FocusNode();
  TextEditingController? _controller ;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: context.height*0.025),
      width: context.width*0.75,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]
      ),
      child: TextFormField(
        validator: (value){
          if(value != null && value.isEmpty)
            return "Veuillez saisir votre mot de passe";

          },
        onChanged: (value){
          widget.getContent!(value);
        },
        textInputAction: TextInputAction.done,
        focusNode: _focusNode,
        onEditingComplete: () {
          setState(() {
            _focusNode.unfocus();
          });
        },
        controller : _controller ,
        obscureText: widget.type=="password"?show:false,
        keyboardType: widget.type=='email' ? TextInputType.emailAddress:TextInputType.text,
        decoration :InputDecoration(
          prefixIcon: widget.type=='password'?Icon(Icons.vpn_key_rounded):Icon(Icons.backpack,),
          suffixIcon: widget.type=='password' ? InkWell(
              splashColor: Colors.transparent,
              onTap: (){
                setState(() {
                  show=!show;
                });
              },
              child: Icon(Icons.remove_red_eye_outlined)):null,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          hintText:widget.hint,
          hintStyle: TextStyle(
            color:Colors.grey[400],
            fontSize:  context.width*0.04,
          ),
        ),
      ),
    );
  }
}

