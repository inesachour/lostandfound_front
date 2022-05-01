import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/registerUserModel.dart';
import 'package:lostandfound/services/image_picker.dart';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/form_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;
var registerService = RegisterService();
var usersService = UsersService();

gettingUser() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var id = prefs.getString("_id");
  var user = await registerService.findRegistredUser(id!);
  print(user!.firstName);

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

  //Controller
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
    // //initial values
    // _lastNameController.text = _last;


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
          "Modifier..",
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
                _lastNameController.text = user!.lastName;
                _firstNameController.text = user!.firstName;
                _phoneController.text = user!.phone;
                _emailController.text = user!.email;
                _passwordController.text = user!.password;
                _confirmPasswordController.text = user!.password;
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
                          SizedBox(
                            height: 25,
                          ),
                          RegisterInputField(
                            decoration: buildInputDecoration(
                                Icons.title, "Nom", "Nom", null),
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            controller: _lastNameController,
                            validator: validator,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RegisterInputField(
                            decoration: buildInputDecoration(
                                Icons.title, "Prénom", "Prénom", null),
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            controller: _firstNameController,
                            validator: validator,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RegisterInputField(
                            decoration: buildInputDecoration(
                                Icons.phone, "Téléphone", "Téléphone", null),
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            controller: _phoneController,
                            validator: phoneValidator,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RegisterInputField(
                            decoration: buildInputDecoration(
                                Icons.email, "E-mail", "E-mail", null),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            controller: _emailController,
                            validator: emailValidator,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RegisterInputField(
                            decoration: buildInputDecoration(
                                Icons.password,
                                "Mot de passe",
                                "Mot de passe",
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        eyeForPassword = !eyeForPassword;
                                      });
                                    },
                                    icon: Icon(Icons.remove_red_eye))),
                            keyboardType: TextInputType.text,
                            obscureText: eyeForPassword,
                            controller: _passwordController,
                            validator: passwordValidator,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RegisterInputField(
                            decoration: buildInputDecoration(
                                Icons.password,
                                "Confirmer le mot de passe",
                                "Mot de passe",
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        eyeForConfirmPassword =
                                            !eyeForConfirmPassword;
                                      });
                                    },
                                    icon: Icon(Icons.remove_red_eye))),
                            keyboardType: TextInputType.text,
                            obscureText: eyeForConfirmPassword,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Resaisir le mot de passe';
                              }
                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                return "Mots de passe non identiques";
                              }
                              return null;
                            },
                            maxLines: 1,
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
                                  Size(width * 0.9, 50)),
                            ),
                            onPressed: () async {
                              final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                              final SharedPreferences prefs = await _prefs;
                              var _id = prefs.getString("_id");
                              var user = await registerService.findRegistredUser(_id!);
                              var ver = user.verified;
                              print(ver);
                              if (_formKey.currentState!.validate()) {
                                print(_firstNameController.text);
                                print(_lastNameController.text);
                                print(_phoneController.text);
                                print(_emailController.text);
                                print(_passwordController.text);
                                usersService.updateUser(
                                  id: _id,
                                  firstName: _firstNameController.text == "" ? _firstNameController.text : user.firstName,
                                  lastName: _lastNameController.text == "" ? _lastNameController.text : user.lastName,
                                  phone: _phoneController.text == "" ? _phoneController.text : user.phone,
                                  email: _emailController.text == "" ? _emailController.text : user.email,
                                  password: _passwordController.text == "" ? _passwordController.text : user.password,
                                  photo: _photo,
                                  role: user.role,
                                  verified: user.verified,
                                );
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
                            onPressed: () {},
                          ),
                          SizedBox(
                            height : 200,
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
