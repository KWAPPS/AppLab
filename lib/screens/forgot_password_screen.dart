import 'package:connect_app/screens/splash_screen.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/utilities/custom_containers.dart';
import 'package:connect_app/utilities/password_reset_functionality.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/utilities/return_popup.dart';

String emailForReset;

PasswordResetFunctionality _passwordResetFunctionality =
    PasswordResetFunctionality();

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Enter the email you used to sign up for quickc.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kDarkBlue2, fontFamily: 'Nunito'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CredentialsTextField(
                fillColor: kDarkPurple,
                barText: 'email',
                onChanged: (value) {
                  emailForReset = value;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomRaisedButton(
              buttonText: 'submit',
              buttonColor: Color(0xFF2B95FF),
              onPressed: () {
                ReturnPopup(
                    context: context,
                    displayText: 'check your email for our password reset link',
                    builderCallback: (context) =>
                        SplashScreen()).triggerPopup();
                _passwordResetFunctionality.sendPasswordResetEmail();
                print('submit button pressed');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                'We will send you an email so you can reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Nunito', color: kDarkBlue2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
