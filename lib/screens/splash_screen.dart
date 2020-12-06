import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:connect_app/utilities/constants.dart';
import 'in_app/home_screen.dart';
import 'welcome_screen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connect_app/screens/timeline.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkSession().then((status) {
      if (status) {
        _navigateToHome();
        print(
            'current user_________________________________-${_auth.currentUser.email}');
      } else {
        _navigateToWelcome();
      }
    });
  }

  Future<bool> _checkSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    try {
      if (_auth.currentUser.emailVerified) {
        return true;
      }
      if (!_auth.currentUser.emailVerified) {
        return false;
      }

      if (_auth.currentUser == null) {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Timeline(),
      ),
    );
  }

  void _navigateToWelcome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.white,
              constraints: BoxConstraints.expand(),
            ),
            Shimmer.fromColors(
              baseColor: Color(0xFF9ad3bc),
              highlightColor: kPurple,
              child: Text(
                'quickc.',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Pacifico',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
