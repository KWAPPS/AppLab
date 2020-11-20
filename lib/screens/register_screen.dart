import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/custom_containers.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/in_app/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff000046),
              Color(0xff1CB5E0),
            ],
            begin: Alignment.centerRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create ',
                          style: kRegisterTextStyle,
                        ),
                        Text(
                          'Account',
                          style: kRegisterTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1,
                        top: MediaQuery.of(context).size.height * 0.17),
                    child: Column(
                      children: [
                        LoginBar(barText: 'Name'),
                        SizedBox(
                          height: 10.0,
                        ),
                        LoginBar(barText: 'Email'),
                        SizedBox(
                          height: 10.0,
                        ),
                        LoginBar(barText: 'Password'),
                        SizedBox(
                          height: 10.0,
                        ),
                        CustomRaisedButton(
                          onPressed: () {
                            print('on pressed');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          buttonColor: kDarkBlue2,
                          buttonText: 'sign up',
                          buttonTextFontSize: 15,
                        ),
                        FlatButton(
                          onPressed: null,
                          child: Text(
                            'Sign in',
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
