import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;

  CategoryCard({this.categoryName = 'Hair Dresser'});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: Center(
            child: Text(
          categoryName,
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'Roboto',
              color: kLightPurple,
              fontWeight: FontWeight.w800),
        )),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      decoration: BoxDecoration(
        color: kDarkBlue2,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      height: 80,
    );
  }
}
