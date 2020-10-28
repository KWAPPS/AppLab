import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/constants.dart';
import 'package:connect_app/custom_containers.dart';

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
                  CustomRaisedButton(
                    buttonText: 'sign in',
                    buttonColor: kLightBlue2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomRaisedButton(
                    buttonColor: kDarkBlue2,
                    buttonText: 'sign up',
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
