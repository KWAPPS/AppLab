import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/in_app/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utilities/constants.dart';
import '../utilities/custom_containers.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kDarkBlue2, // navigation bar color
      statusBarColor: kLightBlue2, // status bar color
    ));
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.all(0),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff000046),
                Color(0xff1CB5E0),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: EdgeInsets.only(
                      left: 10.0,
                      bottom: MediaQuery.of(context).size.height * 0.13),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Welcome', style: kLoginTextStyle),
                      Text('Back', style: kLoginTextStyle),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    // vertical: MediaQuery.of(context).size.height * 0.2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LoginBar(barText: 'Email'),
                      LoginBar(barText: 'Password'),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRaisedButton(
                            onPressed: () {
                              print('on pressed');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            buttonColor: kDarkBlue2,
                            buttonText: 'sign in',
                            buttonTextFontSize: 15,
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FlatButton(
                              onPressed: null,
                              child: Text(
                                'Sign up',
                                style: kSignupTextStyle,
                              ),
                            ),
                            FlatButton(
                              onPressed: null,
                              child: Text(
                                'Forgot Password',
                                style: kSignupTextStyle,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
