import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/custom_widgets/progress.dart';
import 'package:connect_app/utilities/users.dart';

final usersRef = FirebaseFirestore.instance.collection('userData');

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('userData')
        .where('firstName', isGreaterThanOrEqualTo: query)
        .get();
    setState(() {
      searchResultsFuture = users;
    });
  }



  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search user...',
          filled: true,
          prefixIcon: Icon(
            Icons.account_circle,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch(),
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container buildNoContent() {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Icon(
              Icons.group,
              color: Colors.blueAccent,
              size: 200.0,
            ),
            Text(
              'search users',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
        future: searchResultsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<UserResult> searchResults = [];
          snapshot.data.documents.forEach((doc) {
            User user = User.fromDocuments(doc);
            UserResult searchResult = UserResult(user);
            searchResults.add(searchResult);
          });
          return ListView(
            children: searchResults,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => print('tapped'),
          child:
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.profileImageURL),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              user.firstName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              user.description,
              style: TextStyle(color: Colors.white),
            ),
          ),),
          Divider(height: 2.0,color: Colors.white54,)
        ],
      ),
    );
  }
}
