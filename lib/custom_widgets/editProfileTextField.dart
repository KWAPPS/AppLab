import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';

class EditProfileTextField extends StatefulWidget {
  String hintText;
  Function onCompleted;
  Function onChanged;

  EditProfileTextField(
      {@required this.hintText,
      @required this.onCompleted,
      @required this.onChanged});

  @override
  _EditProfileTextFieldState createState() => _EditProfileTextFieldState();
}

class _EditProfileTextFieldState extends State<EditProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontFamily: 'Nunito'),
        onEditingComplete: () {
          print('editing complete');
          widget.onCompleted();
        },
        onChanged: (value) {
          print(value);
          widget.onChanged();
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kDarkBlue2, width: 1.0)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kDarkBlue2, width: 1.0),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Colors.blueGrey, fontSize: 15, fontFamily: 'Nunito'),
        ),
      ),
    );
  }
}
