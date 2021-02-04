import 'package:connect_app/screens/in_app/settings.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/editProfileTextField.dart';

class EditProfilePage extends StatefulWidget {
  String profileImageURL;
  String coverImageURL;

  EditProfilePage({this.profileImageURL, this.coverImageURL});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Edit Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, color: kDarkBlue2, fontFamily: 'Nunito-Bold'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: kLightPurple,
                  radius: 55,
                  backgroundImage: NetworkImage(widget.profileImageURL),
                ),
                Icon(
                  Icons.edit,
                  color: kDarkBlue2,
                )
              ],
            ),
            EditProfileTextField(
                hintText: 'first name',
                onCompleted: () {
                  print('just completed');
                },
                onChanged: () {
                  print('called on changed');
                }),
            EditProfileTextField(
                hintText: 'last name',
                onCompleted: () {
                  print('just completed');
                },
                onChanged: () {
                  print('called on changed');
                }),
            EditProfileTextField(
                hintText: 'what do you do?(eg. designer, barber...)',
                onCompleted: () {
                  print('just completed');
                },
                onChanged: () {
                  print('called on changed');
                }),
            EditProfileTextField(
                hintText: 'brief description',
                onCompleted: () {
                  print('just completed');
                },
                onChanged: () {
                  print('called on changed');
                }),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                'choose a flattering cover image that will appear in search, and home screen',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Nunito', color: Colors.blueGrey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  height: 90,
                  width: 150,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 1),
                  ),
                  decoration: BoxDecoration(
                      color: kLightPurple,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      image: DecorationImage(
                          image: NetworkImage(widget.coverImageURL),
                          fit: BoxFit.fill)),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.edit,
                  color: kDarkBlue2,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            )
          ],
        ),
      ),
    );
  }
}
