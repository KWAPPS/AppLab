import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:connect_app/utilities/constants.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

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
      } else {
        _navigateToWelcome();
      }
    });
  }

  Future<bool> _checkSession() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    return false;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
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
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/white.png'),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints.expand(),
            ),
            Shimmer.fromColors(
              baseColor: Color(0xFF9ad3bc),
              highlightColor: kDarkBlue,
              child: Text(
                'Connect',
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
