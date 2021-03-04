import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connect_app/custom_widgets/action_prompt.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class HireMeScreen extends StatefulWidget {
  String name;
  String email;
  String occupation;
  String phone;

  HireMeScreen({this.name, this.email, this.phone, this.occupation});

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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Hello, my name is ${widget.name}, I can be your ${widget.occupation}.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              color: Colors.yellow[100],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.07,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionPrompt(
                onPressed: () {
                  _launchURL('tel:${widget.phone}');
                },
                iconName: LineAwesomeIcons.phone,
                promptText: 'Call',
              ),
              ActionPrompt(
                onPressed: () {
                  _launchURL(
                      "https://wa.me/${widget.phone}?text=Hello,%20I%20found%20you%20on%20quickc!%20");
                },
                iconName: LineAwesomeIcons.what_s_app,
                promptText: 'WhatsApp',
              ),
              ActionPrompt(
                onPressed: () {
                  _launchURL(
                      'mailto:${widget.email}?subject=INTERESTED IN YOUR SERVICES &body=Hello%20');
                },
                iconName: LineAwesomeIcons.envelope,
                promptText: 'Email',
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.07,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Divider(
              color: Colors.yellow[100],
            ),
          )
        ],
      ),
    );
  }
}
