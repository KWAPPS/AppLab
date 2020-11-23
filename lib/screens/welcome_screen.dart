import 'package:connect_app/screens/login_screen.dart';
import 'package:connect_app/screens/register_screen.dart';

import '../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/utilities/custom_containers.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff000046), // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        margin: EdgeInsets.all(0),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1CB5E0),
              Color(0xff000046),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 50,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                CustomRaisedButton(
                  onPressed: () {
                    print('on pressed');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  buttonText: 'sign in',
                  buttonColor: kDarkBlue2,
                  buttonTextFontSize: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomRaisedButton(
                  onPressed: () {
                    print('on pressed');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  buttonColor: kLightBlue2,
                  buttonText: 'sign up',
                  buttonTextFontSize: 20,
                ),
                SizedBox(
                  height: 100,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
