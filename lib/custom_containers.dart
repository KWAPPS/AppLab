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
