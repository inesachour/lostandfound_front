// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:lostandfound/screens/Home.dart';
import 'package:lostandfound/screens/addpublication.dart';
import 'package:lostandfound/screens/consultpubs.dart';
import 'package:lostandfound/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        "/consultpubs": (context) => Consultpubs(),
        "/addpubs": (context) => AddPublicationForm(),
        "/home": (context) => HomeScreen()
      },
      theme: ThemeData(
          bottomAppBarColor: Colors.grey.shade200,
      ),
      home: LoginScreen()//HomeScreen(),
    );
  }
}

