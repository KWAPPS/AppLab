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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/main.dart';
import 'package:connect_app/push_notifications.dart';

bool showBottomNavigationBar = true;
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// TODO pass over the star rating t edit profile page
class Timeline extends StatefulWidget {
  var currentUserID;
  var currentUserProfileColor;
  var currentUserName;
  var currentUserFirstName;
  var currentUserLastName;
  var currentUserOccupation;
  var currentUserProfileImageURL;
  var currentUserCoverImageURL;
  var currentUserDescription;
  var currentUserPhoneNumber;
  var instagramURL;
  var snapchatURL;
  var twitterURL;

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  PageController pageController;
  int pageIndex = 0;

  Future<double> getRating() async {
    double ratingCounter = 0;
    List<String> reviewers = [];
    double overallRating;
    await FirebaseFirestore.instance
        .collection('reviews')
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {
              if (doc.data()['emailOfReviewee'] ==
                  _firebaseAuth.currentUser.email) {
                ratingCounter =
                    ratingCounter + double.parse(doc.data()['numberOfStars']);

                reviewers.add('a reviewer');
                overallRating = ratingCounter / reviewers.length;
                print(
                    'on timeline, overall rating is $overallRating _______________');
                Provider.of<ProviderData>(context, listen: false)
                    .updateRatingOnMyProfile(overallRating);
              } else {}
            }));

    return overallRating;
  }

  @override
  void initState() {
    getRating();
    pageController = PageController();
    pageController.addListener(() {
      print('tab been switched_____________________');
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent // status bar color
        ));

    FirebaseFirestore.instance
        .collection('userData')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .snapshots()
        .listen((data) {
      try {
        widget.currentUserID = data.docs[0].id;
        widget.currentUserName =
            '${capitalize(data.docs[0]["firstName"])} ${capitalize(data.docs[0]["lastName"])} ';
        widget.currentUserFirstName =
            '${capitalize(data.docs[0]["firstName"])}';
        widget.currentUserLastName = '${capitalize(data.docs[0]["lastName"])}';
        widget.currentUserOccupation = capitalize(data.docs[0]['occupation']);
        widget.currentUserProfileImageURL = data.docs[0]['profileImageURL'];
        widget.currentUserCoverImageURL = data.docs[0]['coverImageURL'];
        widget.currentUserDescription = data.docs[0]['description'];
        widget.currentUserPhoneNumber = data.docs[0]['phoneNumber'];

        if (data.docs[0]['profilePageColor'] == '1') {
          widget.currentUserProfileColor = kDarkBlue2;
        }
        if (data.docs[0]['profilePageColor'] == '4') {
          widget.currentUserProfileColor = kLightBlue;
        }
        if (data.docs[0]['profilePageColor'] == '5') {
          widget.currentUserProfileColor = kEarthGreen;
        }
        if (data.docs[0]['profilePageColor'] == '6') {
          widget.currentUserProfileColor = kOrange;
        }
        if (data.docs[0]['profilePageColor'] == '7') {
          widget.currentUserProfileColor = kDarkPurple;
        }
        if (data.docs[0]['profilePageColor'] == '8') {
          widget.currentUserProfileColor = kBlack;
        }
        if (data.docs[0]['profilePageColor'] == '9') {
          widget.currentUserProfileColor = kPink;
        }
        if (data.docs[0]['profilePageColor'] == '10') {
          widget.currentUserProfileColor = kDarkBrown;
        }
        if (data.docs[0]['profilePageColor'] == '11') {
          widget.currentUserProfileColor = kDarkerBrown;
        }
        if (data.docs[0]['profilePageColor'] == '2') {
          widget.currentUserProfileColor = kPurple;
        }
        if (data.docs[0]['profilePageColor'] == '3') {
          widget.currentUserProfileColor = kDarkGreen;
        }
        widget.snapchatURL = data.docs[0]['snapchatURL'];
        widget.instagramURL = data.docs[0]['instagramURL'];
        widget.twitterURL = data.docs[0]['twitterURL'];
      } catch (e) {
        print(e);
      }
    });

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
          HomeScreen(userID: widget.currentUserID),
          Search(),
          UploadScreen(),
          MyProfile(
            firstName: widget.currentUserFirstName,
            lastName: widget.currentUserLastName,
            phoneNumber: widget.currentUserPhoneNumber,
            idOfUser: widget.currentUserID,
            description: widget.currentUserDescription,
            profilePageColor: widget.currentUserProfileColor,
            coverImageURL: widget.currentUserCoverImageURL,
            idOfProfessional: widget.currentUserID,
            occupation: widget.currentUserOccupation,
            name: widget.currentUserName,
            instagramURL: widget.instagramURL,
            snapchatURL: widget.snapchatURL,
            twitterURL: widget.twitterURL,
            profileImageURL: widget.currentUserProfileImageURL,
            starRating: '4',
            email: FirebaseAuth.instance.currentUser.email,
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Consumer<ProviderData>(
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
