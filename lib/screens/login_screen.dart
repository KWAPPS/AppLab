import 'package:connect_app/screens/forgot_password_screen.dart';
import 'package:connect_app/screens/register_screen.dart';
import 'package:connect_app/utilities/log_in_functionality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utilities/constants.dart';
import '../utilities/custom_containers.dart';

String email;

String password;
UserCredential newUser;
bool showSpinner = false;

LogInFunctionality _logInFunctionality = LogInFunctionality();

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    showSpinner = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff1CB5E0), // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: kDarkBlue2,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Text(
                      'welcome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 50,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF2B95FF),
                          fontFamily: 'Pacifico',
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    )
                  ],
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
                      CredentialsTextField(
                        fillColor: Colors.white,
                        barText: 'email',
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      CredentialsTextField(
                        fillColor: Colors.white,
                        textObscure: true,
                        barText: 'password',
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomRaisedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = !showSpinner;
                          });
                          _logInFunctionality.logInUser(context, () {});
                        },
                        buttonColor: kDarkBlue2,
                        buttonText: 'sign in',
                        buttonTextFontSize: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Text(
                              'forgot password?',
                              style: TextStyle(fontFamily: 'Nunito'),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ForgotPasswordScreen());
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              'sign up',
                              style: TextStyle(fontFamily: 'Nunito'),
                            ),
                          )
                        ],
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
