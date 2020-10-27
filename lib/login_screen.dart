import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'custom_containers.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            onPressed: null,
                            child: Text(
                              'Sign in',
                              style: kSigninTextStyle,
                            ),
                          ),
                          IconButton(
                              icon: FaIcon(FontAwesomeIcons.arrowCircleRight),
                              iconSize: 80.0,
                              color: Colors.black,
                              onPressed: null),
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
//IconButton(
//icon: FaIcon(
//FontAwesomeIcons.solidUserCircle,
//color: Colors.black,
//),
//iconSize: 20.0,
//highlightColor: Colors.redAccent,
//)
