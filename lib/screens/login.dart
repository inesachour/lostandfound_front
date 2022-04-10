// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/services/auth_services.dart';
import 'package:lostandfound/settings/config.dart';
import 'dart:ui' as ui;

import 'package:lostandfound/widgets/login_fields.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? pwd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                CustomPaint(
                  child: Container(
                    height: 175,
                  ),
                  painter: CurvePainter(),
                ),
                SizedBox(
                  height: context.height * 0.07,
                ),
                LoginField(type: "email", hint: "E-mail",getContent: (value){
                  setState(() {
                    email = value;
                  });
                },),
                LoginField(type: "password", hint: "Mot de passe",getContent: (value){
                  setState(() {
                    pwd = value;
                  });
                },),
                SizedBox(
                  height: context.height * 0.03,
                ),
                SizedBox(
                  width: context.width * 0.75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          print("hello");
                        },
                        splashColor: Colors.transparent,
                        child: Text(
                          "mot de passe oublié ? ",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                Container(
                  width: context.width * 0.75,
                  height: context.height*0.06,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Colors.blue.shade600,
                        Colors.blue.shade200,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Auth.Login(email??"",pwd??"").then((value) {
                        if(value)
                          Navigator.of(context).pushReplacementNamed("/home");

                      });
                    },
                    child: Text("Login"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(context.width*0.75,context.height*0.07)),
                      maximumSize: MaterialStateProperty.all(Size(context.width*0.75,context.height*0.09)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      overlayColor: MaterialStateProperty.all(Colors.blue.shade100),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    ),
                  ),
                SizedBox(
                  height: context.height * 0.05,
                ),
              ],
            ),
            Positioned(
                top: context.height * 0.08,
                left: context.width * 0.2,
                child: Column(
                  children: [
                    Text(
                      "Lost And Found",
                      style: TextStyle(
                          color: Colors.white, fontSize: context.width * 0.08),
                    ),
                    Text(
                      "Où rien ne se perd",
                      style: TextStyle(
                          color: Colors.white, fontSize: context.width * 0.04),
                    ),
                  ],
                )),
          ],
        ),
      )),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.7, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    //paint.color = Colors.blue.shade300;
    paint.shader = ui.Gradient.linear(
      Offset(0, 0),
      Offset(size.width * 0.5, size.height),
      [
        Colors.blue.shade600,
        Colors.blue.shade200,
      ],
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
