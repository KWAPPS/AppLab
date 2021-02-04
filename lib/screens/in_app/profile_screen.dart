import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:connect_app/screens/in_app/my_work.dart' as mywork;
import 'package:connect_app/screens/in_app/reviews.dart' as reviews;
import 'package:connect_app/screens/in_app/socials.dart' as socials;
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/custom_widgets/hire_me_button.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO after making a review, and navigating back to home, there isn't any data for the star rating widgets. Figure out how to make it refresh when you go back. You might need to add a back button so that you implement the functionality in navigator.pop

var chosenProfilePageColor = kDarkBlue2;

class ProfileScreen extends StatefulWidget {
  Color profilePageColor;

  String idOfProfessional;
  String name;
  String occupation;
  String email;
  String starRating;
  String profileImageURL;

  ProfileScreen(
      {this.name,
      this.occupation,
      this.starRating,
      this.idOfProfessional,
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
    chosenProfilePageColor = widget.profilePageColor;

    controller = TabController(length: 3, vsync: this);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: chosenProfilePageColor, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    Future.delayed(
        Duration(
          seconds: 1,
        ), () {
      setState(() {});
    });

    super.initState();
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

    setState(() {
      chosenProfilePageColor = widget.profilePageColor;
    });

    return Scaffold(
      backgroundColor: chosenProfilePageColor,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              color: chosenProfilePageColor,
//                margin: EdgeInsets.only(left: 20.0, top: 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            padding: EdgeInsets.only(bottom: 5, top: 15),
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
                          widget.starRating == null
                              ? SizedBox(
                                  height: 1,
                                )
                              : SmoothStarRating(
                                  rating: double.parse(widget.starRating),
                                  isReadOnly: true,
                                  size: 14,
                                  borderColor: Colors.yellowAccent,
                                  filledIconData: FontAwesomeIcons.solidStar,
                                  color: Colors.yellowAccent,
                                  defaultIconData: FontAwesomeIcons.star,
                                  starCount: 5,
                                  allowHalfRating: true,
                                  spacing: 2.0,
                                  onRated: (value) {
                                    print("rating value -> $value");
                                    // print("rating value dd -> ${value.truncate()}");
                                  },
                                ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              widget.occupation,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Nunito',
                                  color: kLightPurple),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: HireMeButton(
                              name: widget.name,
                              occupation: widget.occupation,
                              email: widget.email,
                              buttonColor: kLightBlue2,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: chosenProfilePageColor,
              height: MediaQuery.of(context).size.height * 0.69,
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
                    height: MediaQuery.of(context).size.height * 0.62,
                    child: TabBarView(
                      controller: controller,
                      children: [
                        mywork.MyWork(
                          email: widget.email,
                          color: widget.profilePageColor,
                        ),
                        reviews.Reviews(
                          idOfProfessional: widget.idOfProfessional,
                          email: widget.email,
                          color: widget.profilePageColor,
                          name: widget.name,
                          occupation: widget.occupation,
                          profileImageURL: widget.profileImageURL,
                        ),
                        socials.Socials(
                          color: widget.profilePageColor,
                        )
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
