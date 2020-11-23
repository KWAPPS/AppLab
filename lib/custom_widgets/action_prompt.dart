import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connect_app/utilities/constants.dart';

class ActionPrompt extends StatelessWidget {
  final IconData iconName;
  final String promptText;

  ActionPrompt({@required this.iconName, @required this.promptText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              animationDuration: Duration(seconds: 3),
              visualDensity: VisualDensity.comfortable,
              padding: EdgeInsets.all(15),
              shape: CircleBorder(side: BorderSide.none),
              elevation: 5,
              onPressed: () {
                print('been pressed');
              },
              color: kDarkBlue2,
              child: FaIcon(
                iconName,
                color: Colors.yellow[100],
                size: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 80,
              child: Text(
                promptText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            )
          ],
        ));
  }
}
