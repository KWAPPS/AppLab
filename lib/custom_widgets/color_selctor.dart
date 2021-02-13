import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/provider_data.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ColorSelector extends StatelessWidget {
  Color color;
  String colorNumber;
  String idOfUser;

  ColorSelector({
    this.color,
    this.colorNumber,
    this.idOfUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: GestureDetector(
        onTap: () {
          print('been tapped');
          _firestore
              .collection('userData')
              .doc(idOfUser)
              .update({'profilePageColor': colorNumber});
          Provider.of<ProviderData>(context, listen: false)
              .updateMyProfileColor(color);
        },
        child: Icon(
          Icons.circle,
          color: color,
          size: 40,
        ),
      ),
    );
  }
}
