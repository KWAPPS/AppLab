import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/portfolio_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';

import 'package:connect_app/screens/in_app/profile_screen.dart';

List<PortfolioImage> portfolioColumn1 = [];
List<PortfolioImage> portfolioColumn2 = [];

final _firestore = FirebaseFirestore.instance;

class MyWork extends StatefulWidget {
  String email;
  MyWork({this.email});

  @override
  _MyWorkState createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  @override
  void dispose() {
    portfolioColumn2.clear();
    portfolioColumn1.clear();
    peopleCards.clear();
    morePeopleCards2.clear();
    morePeopleCards1.clear();
    categoryCards.clear();

    print('___________________disposed my work');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chosenProfilePageColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('posts').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      print('oops');
                      return Center(
                          child: CircularProgressIndicator(
                              backgroundColor: kLightPurple));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        backgroundColor: kDarkBlue2,
                      );
                    }

                    final posts = snapshot.data.docs;
                    for (var post in posts) {
                      try {
                        if (post.data()['email'] == widget.email) {
                          PortfolioImage portfolioImage = PortfolioImage(
                              networkImageURL: post.data()['imageURL']);

                          if (portfolioColumn1.length ==
                              portfolioColumn2.length) {
                            portfolioColumn1.add(portfolioImage);
                          } else if (portfolioColumn1.length >
                              portfolioColumn2.length) {
                            portfolioColumn2.add(portfolioImage);
                          }
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    return Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: portfolioColumn1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: portfolioColumn2,
                        )
                      ],
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
