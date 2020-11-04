import 'package:flutter/material.dart';
<<<<<<< Updated upstream:lib/screens/details_screen.dart
import 'package:flutter/services.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/screens/hire_me_screen.dart';
import 'package:connect_app/custom_widgets/portfolio_image.dart';
import 'package:connect_app/custom_widgets/star.dart';
import 'package:connect_app/custom_widgets/review.dart';
=======
import 'file:///C:/Users/user/AndroidStudioProjects/AppLab/lib/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/AppLab/lib/utilities/custom_containers.dart';
import 'package:connect_app/custom_widgets/review.dart';
import 'package:connect_app/custom_widgets/portfolio_image.dart';
import 'package:connect_app/custom_widgets/star.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/AppLab/lib/screens/hire_me_screen.dart';
>>>>>>> Stashed changes:lib/details_screen.dart

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kDarkBlue2, // navigation bar color
      statusBarColor: kDarkBlue2, // status bar color
    ));
    return Scaffold(
      backgroundColor: kDarkBlue2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/avatar1.jpg'),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          ' Freedah Akoth',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      Text(
                        'Events Organizer',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Star(),
                          Star(),
                          Star(),
                          Star(),
                        ],
                      ),
                      RaisedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => HireMeScreen());
                        },
                        padding: EdgeInsets.all(0),
                        child: Text('Hire me'),
                        color: kLightBlue2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      )
                    ],
                  )
                ],
              ),
              Container(
                width: 300,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kLightBlue2,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio1.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio2.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio4.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio6.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio1.jpg',
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio7.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio5.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio7.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio2.jpg',
                                ),
                                PortfolioImage(
                                  assetImagePath: 'images/portfolio1.jpg',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.315,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kLightBlue2),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Reviews',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          Container(
                              width: 70,
                              child: Divider(
                                color: Colors.white,
                              )),
                          Review(
                            reviewText:
                                'Freedah is awesome, she is really friendly and has a sense of humor',
                            reviewerName: 'Gerald',
                          ),
                          Review(
                            reviewerName: 'Becky',
                            reviewText: 'She was really nice to work with',
                          ),
                          Review(
                              reviewerName: 'Dian',
                              reviewText: 'Freedah is so kind'),
                          Review(
                              reviewerName: 'Jason',
                              reviewText: 'She was cool nice to work with'),
                          Review(
                              reviewerName: 'Brad',
                              reviewText:
                                  'Very professional and high quality delivery'),
                          Review(
                              reviewerName: 'Sharon', reviewText: 'Awesome!'),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
