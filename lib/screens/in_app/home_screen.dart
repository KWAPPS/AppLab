import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/provider_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/custom_widgets/category_card.dart';
import 'package:connect_app/custom_widgets/people_card.dart';
import 'package:connect_app/custom_widgets/custom_floating_bottom_bar.dart';
import 'package:connect_app/screens/timeline.dart';
import 'package:provider/provider.dart';

ScrollController _scrollBottomBarController = ScrollController();

bool isScrollingDown = false;
bool showBottomBarOnHome = true;

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
  void showBottomBar() async {
    Provider.of<AppBarData>(context, listen: false).showBottomNavigation();
  }

  void hideBottomBar() async {
    Provider.of<AppBarData>(context, listen: false).hideBottomNavigation();
  }

  void myScroll() async {
    print('my scroll called');
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print('scroll direction is reverse');
        if (!isScrollingDown) {
          isScrollingDown = true;
          showBottomNavigationBar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print('scroll is forward');
        if (isScrollingDown) {
          isScrollingDown = false;
          showBottomNavigationBar = true;
          showBottomBar();
        }
      }
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        // navigation bar color
        statusBarColor: Colors.transparent // status bar color
        ));
    myScroll();

    print('home screen init ___________________________________');
    super.initState();
  }

  @override
  void dispose() {
    peopleCards.clear();
    morePeopleCards2.clear();
    morePeopleCards1.clear();
    categoryCards.clear();
    print('__________________________________disposed home screen');
    _scrollBottomBarController.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        // navigation bar color
        statusBarColor: Colors.transparent // status bar color
        ));
    return Scaffold(
      body: Container(
        color: Colors.white,
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
                        color: Colors.white,
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
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            child: Text(
                              'People Suggestions >',
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
                                      .orderBy('timeStamp', descending: false)
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
                                      try {
                                        if (user.data()['profileImageURL'] !=
                                            null) {
                                          PeopleCard peopleCard = PeopleCard(
                                            profilePageColor: user.data()[
                                                        'profilePageColor'] ==
                                                    'purple'
                                                ? kPurple
                                                : kDarkBlue2,
                                            description:
                                                user.data()['description'],
                                            email: user.data()['email'],
                                            imageURL:
                                                user.data()['profileImageURL'],
                                            occupation:
                                                user.data()['occupation'],
                                            name:
                                                '${user.data()["firstName"]} ${user.data()["lastName"]} ',
                                          );
                                          peopleCards.add(peopleCard);
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
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
                              'More Suggestions >',
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
                                    .orderBy('timeStamp', descending: true)
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
                                    try {
                                      if (user.data()['profileImageURL'] !=
                                          null) {
                                        PeopleCard2 peopleCard2 = PeopleCard2(
                                          imageURL:
                                              user.data()['profileImageURL'],
                                          email: user.data()['email'],
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
                                    } catch (e) {
                                      print(e);
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
          ],
        )),
      ),
    );
  }
}
