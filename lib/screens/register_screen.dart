import 'package:connect_app/screens/login_screen.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../utilities/custom_containers.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connect_app/utilities/registration_functionality.dart';

String email;
String name;
String password;
var registeredUser;
bool showSpinner = false;
RegistrationFunctionality _registrationFunctionality =
    RegistrationFunctionality();

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        color: kLightBlue2,
        inAsyncCall: showSpinner,
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
              begin: Alignment.centerRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      Text(
                        'join',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'quickc.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kLightBlue2,
                            fontFamily: 'Pacifico',
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1,
                        top: MediaQuery.of(context).size.height * 0.35),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        CredentialsTextField(
                          barText: 'email',
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        CredentialsTextField(
                          textObscure: true,
                          barText: 'password',
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        CustomRaisedButton(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            _registrationFunctionality.registerUser(context,
                                () {
                              setState(() {
                                showSpinner = false;
                              });
                            });

                            print(registeredUser.credential);
                          },
                          buttonColor: kDarkBlue2,
                          buttonText: 'sign up',
                          buttonTextFontSize: 15,
                        ),
                        FlatButton(
                          onPressed: null,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              'sign in',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 15.0),
                            ),
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
