import 'package:flutter/material.dart';
import 'package:lostandfound/screens/addpublication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost And Found',
      home: AddPublicationForm(),
    );
  }
}
