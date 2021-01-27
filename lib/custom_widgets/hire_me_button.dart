import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/screens/in_app/hire_me_screen.dart';

class HireMeButton extends StatelessWidget {
  final Color buttonColor;
  String name;
  String email;
  String occupation;

  HireMeButton(
      {this.buttonColor = kLightBlue2, this.occupation, this.name, this.email});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => HireMeScreen(
                  occupation: occupation,
                  name: name,
                  email: email,
                ));
      },
      padding: EdgeInsets.all(0),
      child: Text(
        'Hire me',
        style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
      ),
      color: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    );
  }
}
