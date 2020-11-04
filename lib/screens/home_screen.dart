import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: kDarkBlue2, // status bar color
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlue2,
        title: Center(
          child: Text('App Name Here'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white
            // image: DecorationImage(
            //   image: AssetImage('images/new.png'),
            //   fit: BoxFit.cover,
            // ),
            ),
        // constraints: BoxConstraints.expand(),
        child: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 60.0,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    bottom: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: kDarkBlue2),
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
