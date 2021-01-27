import 'package:connect_app/utilities/constants.dart';
import 'package:popup_box/popup_box.dart';
import 'package:flutter/material.dart';

class ReturnPopup {
  var context;
  String displayText;
  Function builderCallback;

  ReturnPopup(
      {@required this.context,
      @required this.displayText,
      @required this.builderCallback});

  Future triggerPopup() async {
    await PopupBox.showPopupBox(
        context: context,
        button: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: kDarkBlue2,
          child: Text(
            'ok',
            style: TextStyle(fontSize: 15, fontFamily: 'Nunito'),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: builderCallback));
          },
        ),
        willDisplayWidget: Column(
          children: <Widget>[
            Text(
              displayText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30, color: kDarkBlue2, fontFamily: 'Nunito'),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
