import 'package:connect_app/screens/in_app/profile_screen.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/utilities/review_functionality.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FirebaseFirestore _firestore = Firestore.instance;
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final inputTextController = TextEditingController();

List<Review> reviewsList = [];
bool userAlreadyReviewed = false;
String currentUserReviewId;
String idOfTheProfessional;

String valueOfReviewTextField;
String starRating;
double initialRating = 0;

double totalRatings = 0;
double averageRating = 0;

class Reviews extends StatefulWidget {
  String idOfProfessional;
  String email;
  String name;
  String occupation;
  String profileImageURL;
  Reviews(
      {this.email,
      this.name,
      this.idOfProfessional,
      this.occupation,
      this.profileImageURL});

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  void initState() {
    idOfTheProfessional = widget.idOfProfessional;
    reviewsList.clear();
    print('${widget.idOfProfessional}  is id of professional_______________');
    super.initState();
  }

  void dispose() {
    reviewsList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chosenProfilePageColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmoothStarRating(
                rating: initialRating,
                isReadOnly: false,
                size: 19,
                borderColor: Colors.yellowAccent,
                filledIconData: FontAwesomeIcons.solidStar,
                color: Colors.yellowAccent,
                defaultIconData: FontAwesomeIcons.star,
                starCount: 5,
                allowHalfRating: false,
                spacing: 2.0,
                onRated: (value) {
                  starRating = value.toString();
                  print("rating value -> $value");
                  // print("rating value dd -> ${value.truncate()}");
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                    controller: inputTextController,
                    style: TextStyle(color: Colors.white, fontFamily: 'Nunito'),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onEditingComplete: () {
                      ReviewHandling reviewHandling = ReviewHandling();
                      print(valueOfReviewTextField);
                      if (userAlreadyReviewed == false) {
                        reviewHandling.postReview(valueOfReviewTextField,
                            userAlreadyReviewed, widget.email);
                      }
                      if (userAlreadyReviewed) {
                        reviewHandling.upDateReview(
                            currentUserReviewId, valueOfReviewTextField);
                      }

                      inputTextController.clear();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    starRating: averageRating.toString(),
                                    profilePageColor: chosenProfilePageColor,
                                    name: widget.name,
                                    occupation: widget.occupation,
                                    profileImageURL: widget.profileImageURL,
                                    email: widget.email,
                                  )));
                    },
                    onChanged: (value) {
                      valueOfReviewTextField = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                      filled: false,
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      hintText: userAlreadyReviewed
                          ? 'update your review'
                          : 'write your review',
                      hintStyle: TextStyle(
                          color: Colors.white70, fontFamily: 'Nunito'),
                    )),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('reviews').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print('snapshot has no data');
                  }

                  if (snapshot.hasData) {
                    var reviews = snapshot.data.docs;
                    for (var reviewData in reviews) {
                      if (reviewData.data()['emailOfReviewee'] ==
                          widget.email) {
                        if (reviewData.data()['reviewerEmail'] ==
                            _firebaseAuth.currentUser.email) {
                          userAlreadyReviewed = true;
                          print(
                              'current user email is ${_firebaseAuth.currentUser.email} and the '
                              'user who reviewed is ${reviewData.data()['reviewerEmail']} ______________');
                          currentUserReviewId = reviewData.id;
                        }

                        try {
                          Review review = Review(
                            starRating: reviewData.data()['numberOfStars'],
                            reviewText: reviewData.data()['reviewText'],
                            reviewerName: reviewData.data()['firstName'],
                          );

                          reviewsList.add(review);
                          print(
                              '___________current user reviewed? $userAlreadyReviewed');
                          print('with this id $currentUserReviewId __________');
                        } catch (e) {
                          print(e);
                        }
                      }
                    }
                  }

                  return Column(
                    children: reviewsList,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
