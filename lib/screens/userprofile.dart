import 'package:flutter/material.dart';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// gettingUser() async {
//   var registerService = RegisterService();
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final SharedPreferences prefs = await _prefs;
//   var id = prefs.getString("_id");
//   print(id);
//   user = await registerService.findRegistredUser(id!);
//   return(user);
// }

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    //Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(onPressed: () async {
                var registerService = RegisterService();
                final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                final SharedPreferences prefs = await _prefs;
                var id = prefs.getString("_id");
                print(id);
                var user = await registerService.findRegistredUser("62617a2de509bfe94115b610");
                var name = user.firstName;
                print(name);
              }, child: Text("hello"),)
            ],
          ),
        ),
      ),
    );
  }
}
