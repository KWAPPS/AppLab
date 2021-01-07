import 'package:connect_app/screens/splash_screen.dart';
import 'package:connect_app/screens/timeline.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connect_app/screens/login_screen.dart';
import 'package:connect_app/utilities/return_popup.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LogInFunctionality {
  void logInUser(context, Function setState) async {
    try {
      final loggedInUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(loggedInUser.credential);
      setState();
      if (_auth.currentUser.emailVerified) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Timeline()));
      }
      if (_auth.currentUser.emailVerified == false) {
        setState();
        return await ReturnPopup(
            displayText: "email address not verified",
            context: context,
            builderCallback: (context) => SplashScreen()).triggerPopup();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('invalid email');
        ReturnPopup(
            displayText: "wrong password or email",
            context: context,
            builderCallback: (context) => LoginScreen()).triggerPopup();
      } else {
        ReturnPopup(
            displayText: "something went wrong",
            context: context,
            builderCallback: (context) => LoginScreen()).triggerPopup();
      }
    } catch (e) {
      print(e);
      ReturnPopup(
          displayText: "it's not you, it's us😔",
          context: context,
          builderCallback: (context) => LoginScreen()).triggerPopup();
    }
  }
}
