import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../custom_containers.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/IMG-2025.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create Account',
                        style: kRegisterTextStyle,
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
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
                            FlatButton(
                              onPressed: null,
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 40.0, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 50.0, left: 20.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                              onPressed: null,
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30.0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
