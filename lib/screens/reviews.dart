import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReviewsText(
                name: 'Martha J',
                review: 'She delivered timely work beyond our expectations',
              ),
              SizedBox(
                height: 10.0,
              ),
              ReviewsText(
                name: 'Emma P',
                review: 'Great Service',
              ),
              SizedBox(
                height: 10.0,
              ),
              ReviewsText(
                name: 'Nathan T',
                review: 'Very Creative and Amazing to work with',
              ),
              SizedBox(
                height: 10.0,
              ),
              ReviewsText(
                name: 'Maria L',
                review: 'Highly Recommended. Very good service',
              ),
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
