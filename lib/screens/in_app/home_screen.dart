import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/provider_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:connect_app/custom_widgets/category_card.dart';
import 'package:connect_app/custom_widgets/person_info_card.dart';
import 'package:connect_app/screens/timeline.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/main.dart';
import 'package:connect_app/push_notifications.dart';

String placeHolderProfileImage =
    'https://images.unsplash.com/photo-1530305408560-82d13781b33a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80';

ScrollController _scrollBottomBarController = ScrollController();

bool isScrollingDown = false;
bool showBottomBarOnHome = true;

List<PersonInfoCard1> peopleCards = [];
List<PersonInfoCard2> morePeopleCards1 = [];
List<PersonInfoCard2> morePeopleCards2 = [];
List<CategoryCard> categoryCards = [];

final _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  String userID;

  HomeScreen({this.userID});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  void showBottomBar() async {
    Provider.of<ProviderData>(context, listen: false).showBottomNavigation();
  }

  void hideBottomBar() async {
    Provider.of<ProviderData>(context, listen: false).hideBottomNavigation();
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          showBottomNavigationBar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          showBottomNavigationBar = true;
          showBottomBar();
        }
      }
    });
  }

  Stream<QuerySnapshot> _peopleSuggestionsStream;
  Stream<QuerySnapshot> _moreSuggestionsStream;

  @override
  void initState() {
    myScroll();
    _peopleSuggestionsStream = _firestore
        .collection('userData')
        .orderBy('timeStamp', descending: false)
        .snapshots()
        .take(4);
    _moreSuggestionsStream = _firestore
        .collection('userData')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .take(4);

    //initializing the push notifications manager...
    PushNotificationsManager pushNotificationsManager =
        PushNotificationsManager();
    pushNotificationsManager.init(widget.userID);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        // navigation bar color
        statusBarColor: Colors.transparent // status bar color
        ));

    super.initState();
  }

  @override
  void dispose() {
    peopleCards.clear();
    morePeopleCards2.clear();
    morePeopleCards1.clear();
    categoryCards.clear();
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
                                            backgroundColor: kDarkPurple,
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
                                  stream: _peopleSuggestionsStream,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      print('oops');
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: kDarkPurple,
                                        ),
                                      );
                                    }

                                    final users = snapshot.data.docs;

                                    for (var user in users) {
                                      var profileColor = kDarkBlue2;

                                      try {
                                        if (user.data()['profilePageColor'] ==
                                            '1') {
                                          profileColor = kDarkBlue2;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '2') {
                                          profileColor = kPurple;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '4') {
                                          profileColor = kLightBlue;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '5') {
                                          profileColor = kEarthGreen;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '6') {
                                          profileColor = kOrange;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '7') {
                                          profileColor = kDarkPurple;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '8') {
                                          profileColor = kBlack;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '9') {
                                          profileColor = kPink;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '10') {
                                          profileColor = kDarkBrown;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '11') {
                                          profileColor = kDarkerBrown;
                                        }
                                        if (user.data()['profilePageColor'] ==
                                            '3') {
                                          profileColor = kDarkGreen;
                                        }
                                        if (user.data()['profileImageURL'] !=
                                                null &&
                                            user.data()['coverImageURL'] !=
                                                placeHolderProfileImage &&
                                            user.data()['profileImageURL'] !=
                                                'occupation') {
                                          PersonInfoCard1 peopleCard =
                                              PersonInfoCard1(
                                            profilePageColor: profileColor,
                                            idOfProfessional: user.id,
                                            homeScreenReloadCallBack: () {
                                              setState(() {});
                                            },
                                            description:
                                                user.data()['description'],
                                            email: user.data()['email'],
                                            phone: user.data()['phoneNumber'],
                                            imageURL:
                                                user.data()['profileImageURL'],
                                            occupation: capitalize(
                                                user.data()['occupation']),
                                            name:
                                                '${capitalize(user.data()["firstName"])} ${capitalize(user.data()["lastName"])} ',
                                            instagramURL:
                                                user.data()['instagramURL'],
                                            snapchatURL:
                                                user.data()['snapchatURL'],
                                            twitterURL:
                                                user.data()['twitterURL'],
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
                          )
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
                                stream: _moreSuggestionsStream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    print('oops');
                                    return Center(
                                        child: CircularProgressIndicator(
                                            backgroundColor: kDarkPurple));
                                  }

                                  final users = snapshot.data.docs;
                                  for (var user in users) {
                                    var theProfileColor = kDarkBlue2;

                                    try {
                                      if (user.data()['profilePageColor'] ==
                                          '1') {
                                        theProfileColor = kDarkBlue2;
                                      }
                                      if (user.data()['profilePageColor'] ==
                                          '2') {
                                        theProfileColor = kPurple;
                                      }
                                      if (user.data()['profilePageColor'] ==
                                          '3') {
                                        theProfileColor = kDarkGreen;
                                      }

                                      if (user.data()['profileImageURL'] !=
                                              null &&
                                          user.data()['coverImageURL'] !=
                                              placeHolderProfileImage &&
                                          user.data()['profileImageURL'] !=
                                              'occupation') {
                                        PersonInfoCard2 peopleCard2 =
                                            PersonInfoCard2(
                                          profilePageColor: theProfileColor,
                                          idOfProfessional: user.id,
                                          imageURL:
                                              user.data()['profileImageURL'],
                                          coverImageURL:
                                              user.data()['coverImageURL'],
                                          email: user.data()['email'],
                                          occupation: capitalize(
                                              user.data()['occupation']),
                                          name:
                                              '${capitalize(user.data()["firstName"])} ${capitalize(user.data()["lastName"])} ',
                                          instagramURL:
                                              user.data()['instagramURL'],
                                          snapchatURL:
                                              user.data()['snapchatURL'],
                                          twitterURL: user.data()['twitterURL'],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: morePeopleCards1,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
