import 'package:connect_app/screens/in_app/profile_screen.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/review.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
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
              Review(
                reviewText:
                    'She is awesome, she is really friendly and has a sense of humor',
                reviewerName: 'Gerald',
              ),
              Review(
                reviewerName: 'Becky',
                reviewText: 'She was really nice to work with',
              ),
              Review(reviewerName: 'Dian', reviewText: 'Freedah is so kind'),
              Review(
                  reviewerName: 'Jason',
                  reviewText: 'She was cool nice to work with'),
              Review(
                  reviewerName: 'Brad',
                  reviewText: 'Very professional and high quality delivery'),
              Review(reviewerName: 'Sharon', reviewText: 'Awesome!'),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewsText extends StatelessWidget {
  final String name;
  final String review;

  ReviewsText({this.name, this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff1d4d4),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            '☆☆☆☆',
            style: TextStyle(color: Colors.green),
          ),
          Text(
            name,
            style: kReviewText,
          ),
          Text(
            review,
            style: kReviewText,
          ),
        ],
      ),
    );
  }
}
