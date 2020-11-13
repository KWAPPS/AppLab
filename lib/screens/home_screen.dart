import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/custom_widgets/category_card.dart';
import 'package:connect_app/custom_widgets/people_card.dart';
import 'package:connect_app/custom_widgets/custom_floating_bottom_bar.dart';

ScrollController _scrollBottomBarController = ScrollController();

bool isScrollingDown = false;
bool _show = true;

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation sizeAnimation;
  Animation marginAnimation;

  void showBottomBar() async {
    setState(() {
      _show = true;
      controller.reverse();
    });
  }

  void hideBottomBar() async {
    setState(() {
      _show = false;
      controller.forward();
    });
  }

  void myScroll() async {
    print('my scroll called');
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print('scroll direction is reverse');
        if (!isScrollingDown) {
          isScrollingDown = true;
          _show = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
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
    myScroll();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    sizeAnimation = Tween<double>(begin: 60, end: 0).animate(controller);
    marginAnimation = Tween<double>(begin: 20, end: 0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kLightPurple, // navigation bar color
      statusBarColor: kLightPurple, // status bar color
    ));
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kLightPurple,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                controller: _scrollBottomBarController,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                        color: kLightPurple,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              child: Text(
                                'Category Suggestions >',
                                style: kSmallHeadingStyle,
                              ),
                              padding: EdgeInsets.only(left: 15),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CategoryCard(),
                                  CategoryCard(
                                    categoryName: 'Makeup Artist',
                                  ),
                                  CategoryCard(
                                    categoryName: 'Painter',
                                  ),
                                  CategoryCard(
                                    categoryName: 'Graphics Designer',
                                  ),
                                  CategoryCard(
                                    categoryName: 'Dog Trainer',
                                  ),
                                  CategoryCard(
                                    categoryName: 'Painter',
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: kLightPurple,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            child: Text(
                              'Suggestions Near You >',
                              style: kSmallHeadingStyle,
                            ),
                            padding: EdgeInsets.only(left: 15),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                PeopleCards(
                                  name: 'Janet Adoi',
                                  occupation: 'Hair Dresser',
                                  descriptiveText:
                                      "I tap into you afro hair's greatest potential. I do both natural and synthetic hair styles",
                                  imagePath: 'images/avatar2.jpg',
                                ),
                                PeopleCards(
                                  name: 'James Oboth',
                                  occupation: 'Landscaper',
                                  descriptiveText:
                                      'Your compound surely deserves a lot more love. And I am here to give it!',
                                  imagePath: 'images/avatar3.jpg',
                                ),
                                PeopleCards(
                                  name: 'Freedah Akoth',
                                  occupation: 'Events Organizer',
                                  descriptiveText:
                                      'Hello, I worry about the organizing so you can do the partying.',
                                  imagePath: 'images/avatar1.jpg',
                                ),
                                PeopleCards(
                                  name: 'Ashley Mandela ',
                                  occupation: 'Photographer',
                                  descriptiveText:
                                      'My passion is to capture the most brilliant moments through a camera lens.',
                                  imagePath: 'images/avatar4.jpg',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            child: Text(
                              'More Top Suggestions >',
                              style: kSmallHeadingStyle,
                            ),
                            padding: EdgeInsets.only(left: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PeopleCard2(
                                occupation: 'Photographer',
                                name: 'Angela N',
                                assetImagePath: 'images/landscape6.jpg',
                              ),
                              PeopleCard2(
                                occupation: 'Hair Dresser',
                                name: 'Michelle N',
                                assetImagePath: 'images/landscape2.jpg',
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PeopleCard2(
                                occupation: 'Personal Shopper',
                                name: 'Timothy W',
                                assetImagePath: 'images/landscape4.jpg',
                              ),
                              PeopleCard2(
                                occupation: 'Graphics Designer',
                                name: 'Michael O',
                                assetImagePath: 'images/landscape3.jpg',
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PeopleCard2(
                                occupation: 'Dog Trainer',
                                name: 'Jim O',
                                assetImagePath: 'images/landscape5.jpg',
                              ),
                              PeopleCard2(
                                occupation: 'MakeUp Artist',
                                name: 'Annete A',
                                assetImagePath: 'images/landscape1.jpg',
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: sizeAnimation.value,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.85,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Material(
                color: kLightPurple,
                borderRadius: BorderRadius.circular(20.0),
                elevation: 10,
                child: _show == true ? CustomFloatingBottomBar() : null,
              ),
            )
          ],
        )),
      ),
    );
  }
}
