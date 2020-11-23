import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connect_app/custom_widgets/action_prompt.dart';

class HireMeScreen extends StatefulWidget {
  static const String id = 'hire_me_screen';
  @override
  _HireMeScreenState createState() => _HireMeScreenState();
}

class _HireMeScreenState extends State<HireMeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: kDarkBlue2, // navigation bar color
        statusBarColor: kDarkBlue2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          color: kDarkBlue2,
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
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              color: Colors.yellow[100],
            ),
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
