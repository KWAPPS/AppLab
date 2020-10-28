import 'package:flutter/material.dart';

class LoginBar extends StatelessWidget {
  final String barText;
  LoginBar({@required this.barText});
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xfffFFFf2),
          hintText: barText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ));
  }
}

class CustomRaisedButton extends StatelessWidget {
  String buttonText;
  Color buttonColor;

  CustomRaisedButton({this.buttonColor, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      color: buttonColor,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
      ),
      onPressed: () {
        print('been pressed');
      },
    );
  }
}
