
// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lostandfound/screens/consultpubs.dart';
import 'package:lostandfound/screens/userpubs.dart';
import 'package:lostandfound/screens/userprofile.dart';
import 'package:lostandfound/settings/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 3;
  List _children = [
    //UserPubs(),
    UserProfile(),
    Text("Messages Screen "),
    Text("Notifications Screen "),
    Consultpubs(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  Color getColor(int index) {
    if(_currentIndex==index)
    {
      return primaryBlue;
    }
    return Colors.grey.shade600;

  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  late StreamSubscription<bool> keyboardSubscription;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: _children[_currentIndex],
        ),
      ),
      floatingActionButton: _keyboardIsVisible() ? SizedBox() : FloatingActionButton(
        backgroundColor: primaryBlue,
        onPressed: () {
          Navigator.of(context).pushNamed("/addpubs");
        },
        tooltip: 'js',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                padding: EdgeInsets.only(left: 10.0),
                icon: Icon(Icons.account_circle,color: getColor(0),),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                padding: EdgeInsets.only(right: 30.0),
                icon: Icon(Icons.messenger,color: getColor(1),),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                padding: EdgeInsets.only(left: 30.0),
                icon: Icon(Icons.notifications,color: getColor(2),),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                padding: EdgeInsets.only(right: 10.0),
                icon: Icon(Icons.vrpano_sharp,color: getColor(3),),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              )
            ],
          )
      ),
    );
  }
}