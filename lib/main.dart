import 'package:flutter/material.dart';
import 'package:lostandfound/widgets/searchBar.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost And Found',
      home: Scaffold(body: SearchBar(),),
    );
  }
}
