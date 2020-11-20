import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/custom_widgets/search_bar.dart';
import 'package:connect_app/custom_widgets/people_card.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

ScrollController _scrollSearchBarController;
bool isScrollingDown = false;
bool _show = true;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation colorAnimation;

  void showBottomBar() async {
    setState(() {
      _show = true;
      animationController.reverse();
    });
  }

  void hideBottomBar() async {
    setState(() {
      _show = false;
      animationController.forward();
    });
  }

  void scroll() async {
    print('scroll method called');
    _scrollSearchBarController.addListener(() {
      if (_scrollSearchBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print('scroll is reverse');
        if (!isScrollingDown) {
          isScrollingDown = true;
          _show = false;
          hideBottomBar();
        }
      }
      if (_scrollSearchBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print('scroll is forward');
        if (isScrollingDown) {
          isScrollingDown = false;
          _show = true;
          showBottomBar();
        }
      }
    });
  }

  @override
  void initState() {
    _show = true;
    _scrollSearchBarController = ScrollController();
    scroll();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    colorAnimation =
        Tween<double>(begin: 100, end: 500).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kLightPurple, // navigation bar color
      statusBarColor: kLightPurple, // status bar color
    ));
    super.initState();
  }

  @override
  void dispose() {
    _scrollSearchBarController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color: kLightPurple,
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollSearchBarController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Results for "hair stylist">',
                          style: kSmallHeadingStyle,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Angela N',
                            assetImagePath: 'images/landscape6.jpg',
                          ),
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Michelle N',
                            assetImagePath: 'images/landscape2.jpg',
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Timothy W',
                            assetImagePath: 'images/landscape4.jpg',
                          ),
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Michael O',
                            assetImagePath: 'images/landscape3.jpg',
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Jim O',
                            assetImagePath: 'images/landscape5.jpg',
                          ),
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Annete A',
                            assetImagePath: 'images/landscape1.jpg',
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Angela N',
                            assetImagePath: 'images/landscape6.jpg',
                          ),
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Michelle N',
                            assetImagePath: 'images/landscape2.jpg',
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Timothy W',
                            assetImagePath: 'images/landscape4.jpg',
                          ),
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Michael O',
                            assetImagePath: 'images/landscape3.jpg',
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Jim O',
                            assetImagePath: 'images/landscape5.jpg',
                          ),
                          PeopleCard2(
                            occupation: 'Hair Stylist',
                            name: 'Annete A',
                            assetImagePath: 'images/landscape1.jpg',
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: _show == true
                      ? SearchBar(
                          colour: Colors.white,
                        )
                      : null,
                )
              ],
            )),
      ),
    );
  }
}
