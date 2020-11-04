import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/custom_containers.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/screens/home_screen.dart';

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/untitles3.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Create Account',
                      style: kRegisterTextStyle,
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
