import 'package:connect_app/screens/in_app/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Socials extends StatefulWidget {
  Color color;
  String instagramURL;
  String snapchatURL;
  String twitterURL;

  Socials({this.color, this.snapchatURL, this.twitterURL, this.instagramURL});

  @override
  _SocialsState createState() => _SocialsState();
}

class _SocialsState extends State<Socials> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Connect with me on my social media.',
              style: TextStyle(
                  color: Colors.white, fontSize: 17, fontFamily: 'Nunito'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL(widget.instagramURL);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Image.asset('images/instagramIcon.png'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(widget.twitterURL);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Image.asset('images/twitterIcon.png'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(widget.snapchatURL);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Image.asset('images/snapchatIcon.png'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
