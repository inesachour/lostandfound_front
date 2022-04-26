// ignore_for_file: prefer_final_fields

import 'package:google_sign_in/google_sign_in.dart';


class GoogleSignInApi {
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static GoogleSignIn get getAccount => _googleSignIn;

  static Future<GoogleSignInAccount?> login() {
    return _googleSignIn.signIn();
  }  static Future<GoogleSignInAccount?> logout() {
    return _googleSignIn.signOut();
  }
}