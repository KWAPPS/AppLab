import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/custom_widgets/person_info_card.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/utilities/data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;
  final _firestore = FirebaseFirestore.instance;

  Container searchCards() {
    return Container(
      child: ListView(shrinkWrap: true, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              child: Center(
                child: Text(
                  'Search Suggestions >',
                  style: kSmallHeadingStyle,
                ),
              ),
              padding: EdgeInsets.only(left: 15),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.blue,
              height: 400,
              width: 300,
            );
          });
    }
  }
}
// Container(
// child: Center(
// child: Text(
// 'Search for a user',
// style: TextStyle(color: Colors.black, fontSize: 30.0),
// ),
// ),
// ),
