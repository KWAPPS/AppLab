import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connect_app/custom_containers.dart';
import 'package:connect_app/custom_widgets/star.dart';

class Review extends StatelessWidget {
  String reviewerName;
  String reviewText;

  Review({this.reviewerName, this.reviewText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  reviewerName,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45),
                ),
                Star(),
                Star(),
                Star(),
                Star()
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  reviewText,
                  style: TextStyle(fontWeight: FontWeight.w300),
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
