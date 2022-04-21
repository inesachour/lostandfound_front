import 'package:flutter/material.dart';
import 'package:lostandfound/screens/login.dart';
import 'package:lostandfound/services/registerService.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

var registerService = RegisterService();

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  var msg = "";

  //Form Validation variables
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Page de confirmation"),
        backgroundColor: primaryBlue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            SizedBox(
              height: 30,
            ),
            Text(
                "Vous avez reçu un email de vérification, veuillez consulter votre boite de réception"),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text("Se connecter"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        primaryBlue,
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      fixedSize:
                          MaterialStateProperty.all(Size(width * 0.9, 50)),
                    ),
                    onPressed: () async {
                      final Future<SharedPreferences> _prefs =
                          SharedPreferences.getInstance();
                      final SharedPreferences prefs = await _prefs;
                      var id = prefs.getString("_id");
                      print(id);
                      var user = await registerService.findRegistredUser(id!);
                      var ver = user.verified;
                      print(ver);
                      if (user.verified == true) {
                        setState(() {
                          msg = "";
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      } else {
                        setState(() {
                          msg =
                              "vous n'avez pas encore vérifié votre adresse e-mail";
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text("Renvoyer l'email"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        primaryBlue,
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      fixedSize:
                          MaterialStateProperty.all(Size(width * 0.9, 50)),
                    ),
                    onPressed: () async {
                      final Future<SharedPreferences> _prefs =
                      SharedPreferences.getInstance();
                      final SharedPreferences prefs = await _prefs;
                      var id = prefs.getString("_id");
                      print(id);
                      var user = await registerService.findRegistredUser(id!);
                      var email = user.email;
                      print(email);
                      var res = registerService.resendVerificationEmail(user.email);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
