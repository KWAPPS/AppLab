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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('userData')
                      .orderBy('timeStamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      print('oops');
                      return Center(
                          child: CircularProgressIndicator(
                              backgroundColor: kLightPurple));
                    }

                    final users = snapshot.data.docs;
                    for (var user in users) {
                      var profileColor = kDarkBlue2;

                      try {
                        if (user.data()['profilePageColor'] == '1') {
                          profileColor = kDarkBlue2;
                        }
                        if (user.data()['profilePageColor'] == '2') {
                          profileColor = kPurple;
                        }
                        if (user.data()['profilePageColor'] == '3') {
                          profileColor = kDarkGreen;
                        }
                        if (user.data()['profileImageURL'] != null) {
                          PersonInfoCard2 peopleCard = PersonInfoCard2(
                            profilePageColor: profileColor,
                            description: user.data()['description'],
                            email: user.data()['email'],
                            imageURL: user.data()['profileImageURL'],
                            occupation: user.data()['occupation'],
                            name:
                                '${user.data()["firstName"]} ${user.data()["lastName"]} ',
                          );
                          if (morePeopleCards1.length ==
                              morePeopleCards2.length) {
                            morePeopleCards1.add(peopleCard);
                          } else if (morePeopleCards1.length >
                              morePeopleCards2.length) {
                            morePeopleCards2.add(peopleCard);
                          }
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    return Row(
                      children: [
                        Column(
                          children: morePeopleCards1,
                        ),
                        Column(
                          children: morePeopleCards2,
                        )
                      ],
                    );
                  },
                )
              ],
            )
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
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    snapshotData.docs[index].data()['profileImageURL']),
              ),
              title: Text(
                snapshotData.docs[index].data()['firstName'],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
              ),
              subtitle: Text(
                snapshotData.docs[index].data()['description'],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            );
          });
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              isExecuted = false;
            });
          },
        ),
        appBar: AppBar(
          actions: [
            GetBuilder<DataController>(
                init: DataController(),
                builder: (val) {
                  return IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        val.queryData(searchController.text).then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      });
                })
          ],
          title: TextField(
            decoration: InputDecoration(hintText: 'Search User...'),
            controller: searchController,
          ),
        ),
        body: isExecuted ? searchedData() : searchCards());
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
