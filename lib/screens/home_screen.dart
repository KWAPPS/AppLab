import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Center(
          child: Text('App Name'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/new.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 60.0,
                margin: EdgeInsets.only(left: 30.0, right: 50.0, bottom: 30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: kDarkBlue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.home),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.search),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.userCircle),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.bars),
                      onPressed: null,
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
