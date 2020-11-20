import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/in_app/search_screen.dart';

class CustomFloatingBottomBar extends StatelessWidget {
  const CustomFloatingBottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.home,
            color: kDarkBlue2,
          ),
          onPressed: null,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          },
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.search,
              color: kDarkBlue2,
            ),
            onPressed: null,
          ),
        ),
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.userCircle,
            color: kDarkBlue2,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.bars,
            color: kDarkBlue2,
          ),
          onPressed: null,
        )
      ],
    );
  }
}
