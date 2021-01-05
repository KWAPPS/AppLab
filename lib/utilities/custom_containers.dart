import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CredentialsTextField extends StatelessWidget {
  final String barText;
  Function onChanged;
  bool textObscure;
  Color fillColor;

  CredentialsTextField(
      {@required this.barText,
      this.fillColor,
      this.onChanged,
      this.textObscure = false});
  @override
  Widget build(BuildContext context) {
    return TextField(
        style: TextStyle(color: kDarkBlue2, fontFamily: 'Nunito'),
        keyboardType: TextInputType.emailAddress,
        obscureText: textObscure,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2),
          filled: true,
          fillColor: fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
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
            color: Colors.white,
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
