// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:lostandfound/screens/addpublication.dart';
import 'package:lostandfound/screens/consultpubs.dart';
import 'package:lostandfound/settings/colors.dart';

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
      routes: {"/consultpubs": (context) => Consultpubs()},
      theme: ThemeData(
          bottomAppBarColor: Colors.grey.shade200,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
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
  Color? getColor(int index) {
    if(_currentIndex==index)
      {
        return primaryBlue;
      }
    return primaryGrey;

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
        backgroundColor: primaryBlue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPublicationForm()));
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
