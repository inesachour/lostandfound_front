// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:lostandfound/screens/Home.dart';
import 'package:lostandfound/screens/consultpubs.dart';

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
        "/consultpubs": (context) => Consultpubs()
      },
      theme: ThemeData(
          bottomAppBarColor: Colors.grey.shade200,
      ),
      home: HomeScreen(),
    );
  }
}

