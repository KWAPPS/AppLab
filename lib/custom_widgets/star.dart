import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connect_app/utilities/constants.dart';

class Star extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.star,
      color: Colors.yellowAccent,
      size: 14,
    );
  }
}
