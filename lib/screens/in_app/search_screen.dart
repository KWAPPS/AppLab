import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/search_bar.dart';
import 'package:connect_app/custom_widgets/people_card.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/provider_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/custom_widgets/progress.dart';


ScrollController _scrollSearchBarController;
bool isScrollingDown = false;
bool _showSearchBar = true;
bool showBottomBarOnSearch = true;

List<PeopleCard2> searchResults1 = [];
List<PeopleCard2> searchResults2 = [];

String searchTermValue;

// final usersReference = FirebaseFirestore.instance.collection('userData');
Future<QuerySnapshot> searchResultsFuture;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  void showSearchAndBottomBar() async {
    setState(() {
      Provider.of<AppBarData>(context, listen: false).showBottomNavigation();
      _showSearchBar = true;
    });
  }

  void hideSearchAndBottomBar() async {
    setState(() {
      _showSearchBar = false;
      Provider.of<AppBarData>(context, listen: false).hideBottomNavigation();
    });
  }

  void scroll() async {
    print('scroll method called');
    _scrollSearchBarController.addListener(() {
      if (_scrollSearchBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print('scroll is reverse');
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showSearchBar = false;
          hideSearchAndBottomBar();
        }
      }
      if (_scrollSearchBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print('scroll is forward');
        if (isScrollingDown) {
          isScrollingDown = false;
          _showSearchBar = true;
          showSearchAndBottomBar();
        }
      }
    });
  }

  handleSearch(String query) async {
    Future<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('userData')
        .where('firstName', isGreaterThanOrEqualTo: searchTermValue)
        .get();
    setState(() {
      searchResultsFuture = users;
    });

    print('handled search for ... $searchTermValue');
  }

  buildSearchResults() {
    return;
  }

  @override
  void initState() {
    _showSearchBar = true;
    _scrollSearchBarController = ScrollController();
    scroll();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    super.initState();
  }

  @override
  void dispose() {
    _scrollSearchBarController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: [
              searchResultsFuture == null
                  ? Text(
                      'nothing to see',
                      style: TextStyle(color: Colors.black),
                    )
                  : FutureBuilder(
                      future: searchResultsFuture,
                      builder: (context, snapshot) {
                        try {
                          if (!snapshot.hasData) {
                            return circularProgress();
                          }
                          if (snapshot.hasData) {
                            final users = snapshot.data.docs;
                            print('users.length ${users.length}');
                            for (var user in users) {
                              print('snapshot may have data');
                              PeopleCard2 peopleCard2 = PeopleCard2(
                                imageURL: user.data()['profileImageURL'],
                                occupation: user.data()['occupation'],
                                name:
                                    '${user.data()["firstName"]} ${user.data()["lastName"]} ',
                              );

                              if (searchResults1.length ==
                                  searchResults2.length) {
                                searchResults1.add(peopleCard2);
                              } else if (searchResults1.length >
                                  searchResults2.length) {
                                searchResults2.add(peopleCard2);
                              }
                              print(
                                  'searchresults1 len ${searchResults1.length}');
                            }
                          }
                        } catch (e) {
                          print(e);
                        }

                        return SingleChildScrollView(
                          child: Row(
                            children: [
                              Column(
                                children: searchResults1,
                              ),
                              Column(
                                children: searchResults2,
                              )
                            ],
                          ),
                        );
                      }),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: _showSearchBar == true
                    ? SearchBar(
                        runSearch: () {
                          print('going to run search');
                          handleSearch(searchTermValue);
                        },
                        colour: Colors.white,
                      )
                    : null,
              )
            ],
          )),
    );
  }
}
