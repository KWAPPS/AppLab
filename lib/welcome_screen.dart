import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/constants.dart';
import 'constants.dart';
import 'login_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kDarkBlue2, // navigation bar color
      statusBarColor: kLightBlue2, // status bar color
    ));
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.all(0),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Padding(
                        padding: EdgeInsets.only(top: 60, left: 10.0),
                        child: Text(
                          'Welcome',
                          style: kLoginTextStyle,
                        )),
                  ),
                  SizedBox(
                    width: 30.0,
                  )
                ],
              ),
              Column(
                children: [
                  RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                    color: kLightBlue2,
                    child: Text(
                      'sign in',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                      print('been pressed');
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                    color: kDarkBlue2,
                    child: Text(
                      'sign up',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      print('been pressed');
                    },
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/untitles3.png'),
                  fit: BoxFit.cover))),
    );
  }
}
