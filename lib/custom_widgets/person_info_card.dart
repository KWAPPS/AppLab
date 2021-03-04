import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:connect_app/custom_widgets/hire_me_button.dart';
import 'package:connect_app/screens/in_app/profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/provider_data.dart';

double theOverallRating1;
double theOverallRating2;

class PersonInfoCard1 extends StatefulWidget {
  final String description;
  final String imageURL;
  final String name;
  Function homeScreenReloadCallBack;
  final String occupation;
  final String idOfProfessional;
  final String email;
  Color profilePageColor;
  double numberOfStarsInTheWidget;
  String phone;
  String instagramURL;
  String snapchatURL;
  String twitterURL;

  PersonInfoCard1(
      {this.description,
      this.numberOfStarsInTheWidget,
      this.homeScreenReloadCallBack,
      this.idOfProfessional,
      this.imageURL,
      this.profilePageColor,
      this.instagramURL,
      this.twitterURL,
      this.snapchatURL,
      this.phone,
      this.name,
      this.email,
      this.occupation});

  @override
  _PersonInfoCard1State createState() => _PersonInfoCard1State();
}

class _PersonInfoCard1State extends State<PersonInfoCard1> {
  Future getRating() async {
    double ratingCounter = 0;
    List<String> reviewers = [];
    double overallRating;
    await FirebaseFirestore.instance
        .collection('reviews')
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {
              if (doc.data()['emailOfReviewee'] == widget.email) {
                ratingCounter =
                    ratingCounter + double.parse(doc.data()['numberOfStars']);
                reviewers.add('a reviewer');
                overallRating = ratingCounter / reviewers.length;
                theOverallRating1 = overallRating;
                Provider.of<ProviderData>(context, listen: false)
                    .updateStarWidgetInCard1(theOverallRating1, widget);
                return theOverallRating1;
              } else {}
            }));
  }

  @override
  void initState() {
    getRating();
    print('_________initialized info card1 _______________');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, AppBarData, child) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          elevation: 3,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          starRating: widget.numberOfStarsInTheWidget != null
                              ? widget.numberOfStarsInTheWidget.toString()
                              : null,
                          idOfProfessional: widget.idOfProfessional,
                          phone: widget.phone,
                          instagramURL: widget.instagramURL,
                          snapchatURL: widget.snapchatURL,
                          twitterURL: widget.twitterURL,
                          profilePageColor: widget.profilePageColor,
                          name: widget.name,
                          occupation: widget.occupation,
                          email: widget.email,
                          profileImageURL: widget.imageURL))).then(
                  (value) => {widget.homeScreenReloadCallBack()});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(
                color: kDarkBlue2,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: kLightBlue2,
                          radius: 40,
                          backgroundImage: NetworkImage(widget.imageURL),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700),
                            ),
                            widget.numberOfStarsInTheWidget == null
                                ? SizedBox(
                                    height: 2,
                                  )
                                : SmoothStarRating(
                                    rating: widget.numberOfStarsInTheWidget,
                                    isReadOnly: true,
                                    size: 12,
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
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.occupation,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  color: kVeryLightBlue),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        color: kVeryLightBlue,
                        height: 1,
                        width: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 180,
                        child: Text(
                          widget.description,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Nunito'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    HireMeButton(
                      phone: widget.phone,
                      occupation: widget.occupation,
                      buttonColor: kLightBlue2,
                      name: widget.name,
                      email: widget.email,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PersonInfoCard2 extends StatefulWidget {
  String imageURL;
  String name;
  String coverImageURL;
  String email;
  String occupation;
  String description;
  Color profilePageColor;
  String idOfProfessional;
  double numberOfStarsInWidget;
  String instagramURL;
  String snapchatURL;
  String twitterURL;
  String phone;

  PersonInfoCard2(
      {this.imageURL = 'images/portfolio2.jpg',
      this.name = 'Michael Okoth',
      this.email,
      this.numberOfStarsInWidget,
      this.coverImageURL,
      this.idOfProfessional,
      this.profilePageColor,
      this.description,
      this.phone,
      this.instagramURL,
      this.twitterURL,
      this.snapchatURL,
      this.occupation = 'photographer'});

  @override
  _PersonInfoCard2State createState() => _PersonInfoCard2State();
}

class _PersonInfoCard2State extends State<PersonInfoCard2> {
  Future<double> getRating() async {
    double ratingCounter = 0;
    List<String> reviewers = [];
    double overallRating;
    await FirebaseFirestore.instance
        .collection('reviews')
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {
              if (doc.data()['emailOfReviewee'] == widget.email) {
                ratingCounter =
                    ratingCounter + double.parse(doc.data()['numberOfStars']);

                reviewers.add('a reviewer');
                overallRating = ratingCounter / reviewers.length;
                theOverallRating2 = overallRating;
                Provider.of<ProviderData>(context, listen: false)
                    .updateStarWidgetInCard2(theOverallRating2, widget);
              } else {}
            }));

    return overallRating;
  }

  void initState() {
    getRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, AppBarData, child) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                      idOfProfessional: widget.idOfProfessional,
                      starRating: widget.numberOfStarsInWidget != null
                          ? widget.numberOfStarsInWidget.toString()
                          : null,
                      profilePageColor: widget.profilePageColor,
                      phone: widget.phone,
                      name: widget.name,
                      occupation: widget.occupation,
                      instagramURL: widget.instagramURL,
                      snapchatURL: widget.snapchatURL,
                      twitterURL: widget.twitterURL,
                      email: widget.email,
                      profileImageURL: widget.imageURL)));
        },
        child: Container(
          child: Column(
            children: [
              Container(
                height: 90,
                width: 150,
                child: Text(
                  '.',
                  style: TextStyle(fontSize: 1),
                ),
                decoration: BoxDecoration(
                    color: kLightBlue2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    image: DecorationImage(
                        image: NetworkImage(widget.coverImageURL),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.name,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 100,
                  color: Colors.white,
                  height: 1,
                ),
              ),
              Text(
                widget.occupation,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    color: kVeryLightBlue,
                    fontWeight: FontWeight.w600),
              ),
              widget.numberOfStarsInWidget == null
                  ? SizedBox(
                      height: 1,
                    )
                  : SmoothStarRating(
                      rating: widget.numberOfStarsInWidget,
                      isReadOnly: true,
                      size: 12,
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
            ],
          ),
          height: 190,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kDarkBlue2,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      );
    });
  }
}
