import 'package:connect_app/screens/timeline.dart';
import 'package:flutter/material.dart';

import 'package:connect_app/screens/in_app/my_work.dart' as mywork;
import 'package:connect_app/screens/in_app/reviews.dart' as reviews;
import 'package:connect_app/screens/in_app/socials.dart' as socials;
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/custom_widgets/hire_me_button.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';
import 'my_work.dart';

var chosenProfilePageColor = kDarkBlue2;

class ProfileScreen extends StatefulWidget {
  Color profilePageColor;
  String name;
  String occupation;
  String email;
  String profileImageURL;

  ProfileScreen(
      {this.name,
      this.occupation,
      this.profilePageColor,
      this.profileImageURL,
      this.email});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: chosenProfilePageColor, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: chosenProfilePageColor, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    chosenProfilePageColor = widget.profilePageColor;
    return Scaffold(
      backgroundColor: chosenProfilePageColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.19,
              color: chosenProfilePageColor,
//                margin: EdgeInsets.only(left: 20.0, top: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: CircleAvatar(
                          backgroundColor: kLightPurple,
                          radius: 50,
                          backgroundImage: NetworkImage(widget.profileImageURL),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              widget.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                          Text(
                            widget.occupation,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito',
                                color: kLightPurple),
                          ),
                          HireMeButton()
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: chosenProfilePageColor,
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Color(0xffcc0e74),
                    controller: controller,
                    tabs: [
                      Tab(
                        child: Text(
                          'my work',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'reviews',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'socials',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: kDarkBlue2,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: TabBarView(
                      controller: controller,
                      children: [
                        mywork.MyWork(
                          email: widget.email,
                        ),
                        reviews.Reviews(),
                        socials.Socials()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
