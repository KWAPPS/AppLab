import 'package:connect_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/utilities/return_popup.dart';
import 'package:connect_app/screens/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';
import 'package:connect_app/screens/register_screen.dart';

import 'dart:async';

FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class RegistrationFunctionality {
  void registerUser(context, Function setState) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await newUser.user.sendEmailVerification();
      await _auth.signOut();
      return await ReturnPopup(
          context: context,
          displayText:
              'check your email and click the link to verify your address, then sign in!',
          builderCallback: (context) => SplashScreen()).triggerPopup();

      registeredUser = newUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Email Already In Use');

        ReturnPopup(
            context: context,
            displayText: 'Email is already is use',
            builderCallback: (context) => RegisterScreen()).triggerPopup();
      }

      if (e.code == 'weak-password') {
        print('password is too weak');
        ReturnPopup(
            context: context,
            displayText: 'weak password',
            builderCallback: (context) => RegisterScreen()).triggerPopup();
      } else {
        ReturnPopup(
            context: context,
            displayText: 'something went wrong',
            builderCallback: (context) => RegisterScreen()).triggerPopup();
      }
    } catch (e) {
      print(e);
      ReturnPopup(
          context: context,
          displayText: 'oops!🙊 something went wrong',
          builderCallback: (context) => RegisterScreen()).triggerPopup();
    }
  }
}
