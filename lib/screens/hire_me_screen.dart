import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HireMeScreen extends StatefulWidget {
  @override
  _HireMeScreenState createState() => _HireMeScreenState();
}

class _HireMeScreenState extends State<HireMeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kLightBlue2, // navigation bar color
      statusBarColor: kDarkBlue2, // status bar color
    ));

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          color: kLightBlue2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 28, bottom: 28),
            child: Text(
              'Hello, my name is Freedah Akoth, and I am an Events Organizer',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionPrompt(
                iconName: FontAwesomeIcons.calendar,
                promptText: 'Book Appointment',
              ),
              ActionPrompt(
                iconName: FontAwesomeIcons.phone,
                promptText: 'Call',
              ),
              ActionPrompt(
                iconName: FontAwesomeIcons.solidEnvelope,
                promptText: 'Message',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ActionPrompt extends StatelessWidget {
  IconData iconName;
  String promptText;

  ActionPrompt({@required this.iconName, @required this.promptText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: RaisedButton(
        onPressed: () {
          print('pressed me');
        },
        padding: EdgeInsets.symmetric(vertical: 10),
        elevation: 2,
        color: kLightBlue2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            FaIcon(
              iconName,
              color: kDarkBlue2,
              size: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 80,
              child: Text(
                promptText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
