import 'package:connect_app/provider_data.dart';
import 'package:connect_app/screens/in_app/my_profile.dart';

import 'package:flutter/material.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';
import 'package:connect_app/screens/in_app/search_page.dart';
import 'package:connect_app/screens/in_app/upload_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bool showBottomNavigationBar = true;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    pageController = PageController();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent // status bar color
        ));

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
    );
  }

  Scaffold bottomBar() {
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          Search(),
          UploadScreen(),
          MyProfile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Consumer<AppBarData>(
        builder: (context, AppBarData, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: showBottomNavigationBar == true
                ? MediaQuery.of(context).size.height * 0.06
                : 0,
            child: showBottomNavigationBar == true
                ? CupertinoTabBar(
                    currentIndex: pageIndex,
                    onTap: onTap,
                    activeColor: Colors.blueAccent,
                    backgroundColor: Colors.white,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(LineAwesomeIcons.home)),
                      BottomNavigationBarItem(
                          icon: Icon(LineAwesomeIcons.search)),
                      BottomNavigationBarItem(
                          icon: Icon(LineAwesomeIcons.plus)),
                      BottomNavigationBarItem(
                          icon: Icon(LineAwesomeIcons.user)),
                    ],
                  )
                : Container(
                    height: 1,
                    color: Colors.white,
                  ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent // status bar color
        ));
    return bottomBar();
  }
}
