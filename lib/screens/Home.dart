
// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lostandfound/screens/consultpubs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 3;
  List _children = [
    Text("Profile Screen "),
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
      return Colors.blue.shade200;
    }
    return Colors.grey.shade600;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: _children[_currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
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
        /*BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Colors.grey.shade100,
                  icon: Icon(Icons.account_circle),
                  label: "profile"),
              BottomNavigationBarItem(
                icon: Icon(Icons.messenger),
                label: 'messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.vrpano_sharp),
                label: 'publications',
              )
            ],
          )*/
      ),
    );
  }
}