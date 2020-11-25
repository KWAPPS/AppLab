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
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: kLightBlue2,
          child: Text(
            'ok',
            style: TextStyle(fontSize: 20, fontFamily: 'Cormorant'),
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
              style: TextStyle(
                  fontSize: 30, color: Colors.white, fontFamily: 'Cormorant'),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
