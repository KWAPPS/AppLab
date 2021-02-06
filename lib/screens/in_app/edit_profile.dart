import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/screens/in_app/confirm_image_upload.dart';
import 'package:connect_app/screens/in_app/settings.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/editProfileTextField.dart';
import 'package:connect_app/provider_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

String userProfileImageURL;
String userCoverImageURL;
bool toggleSpin = false;
bool uploadConfirmed = false;

String defaultProfileImageURL =
    'https://images.unsplash.com/photo-1506318137071-a8e063b4bec0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1070&q=80';

class EditProfilePage extends StatefulWidget {
  String idOfUser;
  String profileImageURL;
  String coverImageURL;

  EditProfilePage({this.idOfUser, this.coverImageURL});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

//TODO add a phone number field with a num keyboard

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  File _image;
  final picker = ImagePicker();

  Future getImage(String pathToUpdate) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Provider.of<ProviderData>(this.context, listen: false)
            .toggleLoadingOnEditProfile();
        showModalBottomSheet(
            context: this.context,
            builder: (context) => ConfirmImageUpload(
                  pathToUpdate: pathToUpdate,
                  userID: widget.idOfUser,
                  image: _image,
                ));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    _firestore
        .collection('userData')
        .doc(widget.idOfUser)
        .snapshots()
        .listen((data) {
      String theUserProfileImageURL = data.get('profileImageURL');
      String theUserCoverImageURL = data.get('coverImageURL');
      Provider.of<ProviderData>(this.context, listen: false)
          .updateProfileImageURL(theUserProfileImageURL);
      Provider.of<ProviderData>(this.context, listen: false)
          .updateCoverImageURL(theUserCoverImageURL);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, AppBarData, child) {
      return ModalProgressHUD(
        inAsyncCall: toggleSpin,
        child: Container(
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
                        fontSize: 15,
                        color: kDarkBlue2,
                        fontFamily: 'Nunito-Bold'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                        backgroundColor: kLightPurple,
                        radius: 55,
                        backgroundImage: userProfileImageURL != null
                            ? NetworkImage(userProfileImageURL)
                            : NetworkImage(defaultProfileImageURL)),
                    GestureDetector(
                      onTap: () {
                        getImage('profileImageURL');
                      },
                      child: Icon(
                        Icons.edit,
                        color: kDarkBlue2,
                      ),
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
                        fontSize: 15,
                        fontFamily: 'Nunito',
                        color: Colors.blueGrey),
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
                              image: userCoverImageURL != null
                                  ? NetworkImage(userCoverImageURL)
                                  : NetworkImage(defaultProfileImageURL),
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
        ),
      );
    });
  }
}
