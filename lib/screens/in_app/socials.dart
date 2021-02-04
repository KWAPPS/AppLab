import 'package:connect_app/screens/in_app/profile_screen.dart';

import 'package:flutter/material.dart';

class Socials extends StatefulWidget {
  Color color;

  Socials({this.color});

  @override
  _SocialsState createState() => _SocialsState();
}

class _SocialsState extends State<Socials> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
    );
  }
}
