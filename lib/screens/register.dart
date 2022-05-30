import 'package:flutter/material.dart';
import 'package:lostandfound/screens/verifyemail.dart';
import 'package:lostandfound/services/image_picker.dart';
import 'dart:io';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/form_widgets.dart';
import 'package:lostandfound/screens/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
    if(value.toString().length < 6 ){
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
  final ImagePickerService _imagePickerService = ImagePickerService();
  File? _photo;

  //Backend Manager
  final RegisterService _registerService = RegisterService();

  @override
  Widget build(BuildContext context) {
    //Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackground,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Column(
          children: [
            Text(
              "Lost And Found",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              "Ou rien ne se perd",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        toolbarHeight: 150,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Créer votre compte",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                      decoration:
                          buildInputDecoration(Icons.title, "Nom", "Nom", null),
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
                      decoration:
                          buildInputDecoration(Icons.title, "Prénom", "Prénom", null),
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
                      decoration:
                          buildInputDecoration(Icons.email, "E-mail", "E-mail", null),
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
                          Icons.password, "Mot de passe", "Mot de passe", IconButton(onPressed: (){  setState(() {
                        eyeForPassword = !eyeForPassword;
                          });}, icon: Icon(Icons.remove_red_eye))),
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
                      decoration: buildInputDecoration(Icons.password,
                          "Confirmer le mot de passe", "Mot de passe", IconButton(onPressed: (){ setState(() {
                            eyeForConfirmPassword = !eyeForConfirmPassword;
                          });}, icon: Icon(Icons.remove_red_eye))),
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
                      child: Text("Rejoindre la communauté"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          primaryBlue,
                        ),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        fixedSize:
                            MaterialStateProperty.all(Size(width * 0.9, 50)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _registerService.register(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            phone: _phoneController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            photo: _photo,
                            role: "user",
                            verified: false,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VerifyEmail()),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style : TextStyle(
                                fontSize: 12,
                                color: primaryGrey,
                              ),
                            children : <TextSpan>[
                              TextSpan(text: "En créant un compte, vous acceptez les "),
                              TextSpan(text: "conditions d'utilisation", style: TextStyle(
                                color: primaryBlue,
                              ),),
                              TextSpan(text: " et "),
                              TextSpan(text: "politique de confidentialité", style: TextStyle(
                                color: primaryBlue,
                              ),),
                              TextSpan(text: " de Lost and Found.")
                            ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.7,
                                  color: Colors.black,
                                ),
                              ),
                              Text(" ou "),
                              Expanded(
                                child: Divider(
                                  thickness: 0.7,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: Text(
                              "Se connecter avec Google",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
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
                            height: 10,
                          ),
                          ElevatedButton(
                            child: Text(
                              "Se connecter avec Facebook",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
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
                            height: 20,
                          ),
                          TextButton(
                            child: Text(
                              "Vous avez déjà un compte?",
                              style: TextStyle(
                                color: primaryGrey,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
