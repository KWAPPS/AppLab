import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class LoginBar extends StatelessWidget {
  final String barText;
  LoginBar({@required this.barText});
  @override
  Widget build(BuildContext context) {
    return TextField(
        textAlign: TextAlign.center,
        onChanged: (value) {},
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kDarkBlue2, width: 1.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kDarkBlue2, width: 2.0),
          ),
          hintText: barText,
          hintStyle: TextStyle(
            color: Colors.black45,
          ),
        ));
  }
}

class CustomRaisedButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function onPressed;
  final double buttonTextFontSize;

  CustomRaisedButton(
      {this.buttonColor,
      this.buttonText,
      this.onPressed,
      this.buttonTextFontSize});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 5),
      color: buttonColor,
      child: Text(
        buttonText,
        style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: buttonTextFontSize,
            fontWeight: FontWeight.w600),
      ),
      onPressed: onPressed,
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  ProfileButton({this.color, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 150.0,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Text(text),
      ),
    );
  }
}
