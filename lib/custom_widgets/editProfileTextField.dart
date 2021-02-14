import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';

class EditProfileTextField extends StatefulWidget {
  String hintText;
  Function onCompleted;

  int maxLength;
  int minLines;
  int maxLines;
  Function onChanged;
  TextInputType textInputType;

  EditProfileTextField(
      {@required this.hintText,
      this.textInputType,
      this.minLines,
      this.maxLength,
      this.maxLines,
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
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        maxLength: widget.maxLength,
        maxLengthEnforced: true,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        keyboardType: widget.textInputType,
        textAlign: TextAlign.left,
        style: TextStyle(color: kDarkBlue2, fontFamily: 'Nunito'),
        onEditingComplete: () {
          widget.onCompleted();
        },
        onChanged: (value) {
          widget.onChanged(value);
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
