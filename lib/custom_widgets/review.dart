import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:connect_app/custom_widgets/star.dart';

class Review extends StatelessWidget {
  final String reviewerName;
  final String reviewText;
  final String starRating;

  Review({this.reviewerName, this.starRating, this.reviewText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  reviewerName,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kDarkPurple),
                ),
                SmoothStarRating(
                  rating: double.parse(starRating),
                  isReadOnly: true,
                  size: 10,
                  borderColor: Colors.yellowAccent,
                  filledIconData: FontAwesomeIcons.solidStar,
                  color: Colors.yellowAccent,
                  defaultIconData: FontAwesomeIcons.star,
                  starCount: 5,
                  allowHalfRating: false,
                  spacing: 2.0,
                  onRated: (value) {
                    print("rating value -> $value");
                    // print("rating value dd -> ${value.truncate()}");
                  },
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  reviewText,
                  style: TextStyle(
                      fontFamily: 'Nunito', fontWeight: FontWeight.w300),
                )),
            Divider(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
