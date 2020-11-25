import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('invalid email');
        ReturnPopup(
            displayText: "user not found",
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
