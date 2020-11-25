import 'package:cloud_firestore/cloud_firestore.dart';
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

List<PeopleCard> peopleCards = [];
List<PeopleCard2> morePeopleCards1 = [];
List<PeopleCard2> morePeopleCards2 = [];
List<CategoryCard> categoryCards = [];

final _firestore = FirebaseFirestore.instance;

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: kLightPurple,
        // navigation bar color
        statusBarColor: Colors.transparent // status bar color
        ));
    myScroll();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    sizeAnimation = Tween<double>(begin: 60, end: 0).animate(controller);
    marginAnimation = Tween<double>(begin: 20, end: 0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: kLightPurple,
        // navigation bar color
        statusBarColor: Colors.transparent // status bar color
        ));
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
                                  StreamBuilder<QuerySnapshot>(
                                    stream: _firestore
                                        .collection('categories')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        print('oops');
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: kLightPurple,
                                          ),
                                        );
                                      }

                                      final categories = snapshot.data.docs;
                                      for (var category in categories) {
                                        if (category.data()['categoryName'] !=
                                            null) {
                                          CategoryCard categoryCard =
                                              CategoryCard(
                                            categoryName:
                                                category.data()['categoryName'],
                                          );
                                          categoryCards.add(categoryCard);
                                        }
                                      }
                                      return Row(
                                        children: categoryCards,
                                      );
                                    },
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
                                StreamBuilder<QuerySnapshot>(
                                  stream: _firestore
                                      .collection('userData')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      print('oops');
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: kLightPurple,
                                        ),
                                      );
                                    }

                                    final users = snapshot.data.docs;
                                    for (var user in users) {
                                      PeopleCard peopleCard = PeopleCard(
                                        descriptiveText:
                                            user.data()['description'],
                                        imageURL:
                                            user.data()['profileImageURL'],
                                        occupation: user.data()['occupation'],
                                        name:
                                            '${user.data()["firstName"]} ${user.data()["lastName"]} ',
                                      );

                                      peopleCards.add(peopleCard);
                                    }
                                    return Row(
                                      children: peopleCards,
                                    );
                                  },
                                )
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
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('userData')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    print('oops');
                                    return Center(
                                        child: CircularProgressIndicator(
                                            backgroundColor: kLightPurple));
                                  }

                                  final users = snapshot.data.docs;
                                  for (var user in users) {
                                    PeopleCard2 peopleCard2 = PeopleCard2(
                                      imageURL: user.data()['profileImageURL'],
                                      occupation: user.data()['occupation'],
                                      name:
                                          '${user.data()["firstName"]} ${user.data()["lastName"]} ',
                                    );

                                    if (morePeopleCards1.length ==
                                        morePeopleCards2.length) {
                                      morePeopleCards1.add(peopleCard2);
                                    } else if (morePeopleCards1.length >
                                        morePeopleCards2.length) {
                                      morePeopleCards2.add(peopleCard2);
                                    }
                                  }
                                  return Row(
                                    children: [
                                      Column(
                                        children: morePeopleCards1,
                                      ),
                                      Column(
                                        children: morePeopleCards2,
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          )
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
