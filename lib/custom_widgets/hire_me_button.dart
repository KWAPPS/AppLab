import 'package:connect_app/screens/details_screen.dart';
import 'package:connect_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/screens/hire_me_screen.dart';

class HireMeButton extends StatelessWidget {
  final Color buttonColor;

  HireMeButton({this.buttonColor = kLightBlue2});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        showModalBottomSheet(
            context: context, builder: (context) => HireMeScreen());
      },
      padding: EdgeInsets.all(0),
      child: Text(
        'Hire me',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      color: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
