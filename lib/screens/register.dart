import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/services/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/services/backend_manager.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/form_widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Form Validation variables
  final _formKey = GlobalKey<FormState>();

  //Controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  //obligation validator
  var validator = (value) {
    if (value == null || value.isEmpty) {
      return 'Champ obligatoire';
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
  List<File> _photos = [];

  //Backend Manager
  BackendManager _backendManager = BackendManager();

  @override
  Widget build(BuildContext context) {
    //Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackground,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text("Lost And Found",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text("Ou rien ne se perd",
            style: TextStyle(
              fontSize: 13,
            ),
            ),
          ],
        ),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40,),
              Text(
                "Créer votre compte",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    RegisterInputField(
                      decoration:
                          buildInputDecoration(Icons.title, "Nom", "Nom"),
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      controller: _nameController,
                      validator: validator,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RegisterInputField(
                      decoration:
                          buildInputDecoration(Icons.title, "Prénom", "Prénom"),
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
                          Icons.phone, "Téléphone", "Téléphone"),
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
                          buildInputDecoration(Icons.email, "E-mail", "E-mail"),
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
                          Icons.password, "Mot de passe", "Mot de passe"),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: _passwordController,
                      validator: validator,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RegisterInputField(
                      decoration: buildInputDecoration(
                          Icons.password,
                          "Confirmer le mot de passe",
                          "Mot de passe"),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Resaisir le mot de passe';
                        }
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: _photos.length == 0 ? 0 :(((_photos.length-1)/2).toInt()+1)*160,
                      child: _photos==null ? Text("") : GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _photos.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (BuildContext context, int index){
                          return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffd4d8dc), width: 2),
                                  ),
                                  child: Image.file(_photos[index], fit: BoxFit.contain,),
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _photos.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.close_rounded, color: Colors.red,),

                                ),
                              ]
                          );
                        },
                      ),
                    ),
                    Container(
                      child: ( _photos.length >= 4) ? null : TextButton.icon(
                        onPressed: () async{
                          var _images = await _imagePickerService.getPhotosFromGallery();
                          if(_images!=null){
                            setState(() {
                              if(_photos.length >0){
                                _images.forEach((e) {
                                  _photos.add(e);
                                });
                              }else{
                                _photos = _images;
                              }
                            });
                          }
                        },
                        icon: Icon(Icons.add,color: Color(0xff707070),),
                        label: Text("ajouter des photos (maximum : 4)",style: TextStyle(color: Color(0xff707070)),),
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                        ),
                      ),
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
                          print(_nameController.text);
                          print(_lastNameController.text);
                          print(_phoneController.text);
                          print(_emailController.text);
                          print(_passwordController.text);
                          print(_photos[0].path);
                          //_backendManager.register(
                          //title: _titleController.text,
                          //date: _date.toString(),
                          //images: _photo,
                          //owner: User(firstName: "firstName", lastName: "lastName", phone: "phone", email: "email", photo: "photo"),
                          //);
                          //Navigator.pop(context);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil("/", (route) => false);
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                          "En créant un compte, vous acceptez les conditions d'utilisation et politique de confidentialité de Lost And Found",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
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
