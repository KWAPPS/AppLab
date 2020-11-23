import 'package:flutter/material.dart';

import 'package:connect_app/screens/in_app/my_work.dart' as mywork;
import 'package:connect_app/screens/in_app/reviews.dart' as reviews;
import 'package:connect_app/screens/in_app/socials.dart' as socials;
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/custom_widgets/hire_me_button.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
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
      systemNavigationBarColor: kProfilePageColor, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kLightPurple, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kProfilePageColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.19,
              color: kProfilePageColor,
//                margin: EdgeInsets.only(left: 20.0, top: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('images/avatar1.jpg'),
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
                              'Freedah Akoth',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                          Text(
                            'Events Designer',
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
              color: kProfilePageColor,
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Color(0xffcc0e74),
                    controller: controller,
                    tabs: [
                      Tab(
                        text: 'My Work',
                      ),
                      Tab(
                        text: 'Reviews',
                      ),
                      Tab(
                        text: 'Socials',
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
                        mywork.MyWork(),
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
