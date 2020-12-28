import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connect_app/utilities/constants.dart';

final inputTextController = TextEditingController();

class SearchBar extends StatelessWidget {
  final Color colour;
  String searchTerm;

  SearchBar({this.colour, this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextField(
          controller: inputTextController,
          textAlign: TextAlign.left,
          onChanged: (value) {
            searchTerm = value;
          },
          onEditingComplete: () {
            print('editing complete');
            inputTextController.clear();

            print(searchTerm);
          },
          style: TextStyle(
              color: kDarkBlue2,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            filled: true,
            fillColor: colour,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(width: 1, color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(width: 1, color: kLightPurple)),
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
            prefixIconConstraints: BoxConstraints.tightFor(),
            prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FaIcon(
                  FontAwesomeIcons.search,
                  color: kDarkBlue2,
                )),
            hintStyle: TextStyle(color: Colors.blueGrey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ),
      ),
    );
  }
}
