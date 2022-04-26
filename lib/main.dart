// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:lostandfound/screens/Home.dart';
import 'package:lostandfound/screens/addpublication.dart';
import 'package:lostandfound/screens/consultpubs.dart';
import 'package:lostandfound/screens/login.dart';
import 'package:lostandfound/screens/register.dart';
import 'package:lostandfound/services/backend_manager.dart';
import 'package:lostandfound/services/comments_service.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CommentsService.getCommentService),
        ChangeNotifierProvider(create: (context) => BackendManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lost and Found',
        routes: {
          "/consultpubs": (context) => Consultpubs(),
          "/addpubs": (context) => AddPublicationForm(),
          "/home": (context) => HomeScreen(),
          "/login": (context) => LoginScreen(),
          "/register": (context) => Register()
        },
        theme: ThemeData(
          bottomAppBarColor: Colors.grey.shade200,
        ),
        home: LoginScreen(),
    );
  }
}
