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
      systemNavigationBarColor: kLightCream, // navigation bar color
      statusBarColor: kLightCream, // status bar color
    ));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Welcome', style: kLoginTextStyle),
                      Text('Back', style: kLoginTextStyle),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoginBar(barText: 'Email'),
                      SizedBox(
                        height: 10.0,
                      ),
                      LoginBar(barText: 'Password'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: null,
                            child: Text(
                              'Sign in',
                              style: kSigninTextStyle,
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
