import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/screens/in_app/confirm_image_upload.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/editProfileTextField.dart';
import 'package:connect_app/provider_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/custom_widgets/color_selctor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

String userProfileImageURL;
String userCoverImageURL;
bool toggleSpin = false;
bool uploadConfirmed = false;

String description;
String phoneNumber;
String firstName;
String lastName;
String occupation;

String defaultProfileImageURL =
    'https://images.unsplash.com/photo-1506318137071-a8e063b4bec0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1070&q=80';

class EditProfilePage extends StatefulWidget {
  String idOfUser;
  String name;
  String description;
  String phoneNumber;
  String firstName;
  String lastName;
  String occupation;
  String profileImageURL;
  String coverImageURL;

  EditProfilePage(
      {this.idOfUser,
      this.firstName,
      this.lastName,
      this.description,
      this.occupation,
      this.phoneNumber,
      this.coverImageURL});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

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
                ),
            isScrollControlled: true);
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
                        backgroundColor: kVeryLightBlue,
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
                SizedBox(
                  height: 15,
                ),
                Text(
                  'first name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito', fontSize: 12, color: kDarkBlue2),
                ),
                EditProfileTextField(
                    maxLength: 14,
                    hintText: '$firstName',
                    onCompleted: (value) {
                      firstName = value;
                    },
                    onChanged: (value) {
                      firstName = value;
                    }),
                Text(
                  'last name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito', fontSize: 12, color: kDarkBlue2),
                ),
                EditProfileTextField(
                    maxLength: 14,
                    hintText: '$lastName',
                    onCompleted: (value) {
                      lastName = value;
                    },
                    onChanged: (value) {
                      lastName = value;
                    }),
                Text(
                  'what do you do?(eg. designer, barber...)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito', fontSize: 12, color: kDarkBlue2),
                ),
                EditProfileTextField(
                    maxLength: 20,
                    hintText: '$occupation',
                    onCompleted: (value) {
                      occupation = value;
                    },
                    onChanged: (value) {
                      occupation = value;
                    }),
                Text(
                  'brief description (90 characters max)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito', fontSize: 12, color: kDarkBlue2),
                ),
                EditProfileTextField(
                    maxLength: 90,
                    minLines: 1,
                    maxLines: 3,
                    hintText: '$description',
                    onCompleted: (value) {
                      description = value;
                    },
                    onChanged: (value) {
                      description = value;
                    }),
                Text(
                  'phone number (eg. +256700000000)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito', fontSize: 12, color: kDarkBlue2),
                ),
                EditProfileTextField(
                    maxLength: 13,
                    hintText: '$phoneNumber',
                    textInputType: TextInputType.phone,
                    onCompleted: (value) {
                      phoneNumber = value;
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    }),
                Text(
                  'portfolio background color >',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      color: Colors.blueGrey),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorSelector(
                          color: kDarkBlue2,
                          colorNumber: '1',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kPurple,
                          colorNumber: '2',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kDarkGreen,
                          colorNumber: '3',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kLightBlue,
                          colorNumber: '4',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kEarthGreen,
                          colorNumber: '5',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kOrange,
                          colorNumber: '6',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kDarkPurple,
                          colorNumber: '7',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kBlack,
                          colorNumber: '8',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kPink,
                          colorNumber: '9',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kDarkBrown,
                          colorNumber: '10',
                          idOfUser: widget.idOfUser,
                        ),
                        ColorSelector(
                          color: kDarkerBrown,
                          colorNumber: '11',
                          idOfUser: widget.idOfUser,
                        ),
                      ],
                    ),
                  ),
                ),
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
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: MediaQuery.of(context).size.width * 0.54,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 1),
                  ),
                  decoration: BoxDecoration(
                      color: kDarkPurple,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      image: DecorationImage(
                          image: userCoverImageURL != null
                              ? NetworkImage(userCoverImageURL)
                              : NetworkImage(defaultProfileImageURL),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    getImage('coverImageURL');
                  },
                  child: Icon(
                    Icons.edit,
                    size: 28,
                    color: kDarkBlue2,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                RaisedButton(
                  onPressed: () async {
                    Provider.of<ProviderData>(context, listen: false)
                        .toggleLoadingOnEditProfile();
                    print(
                        '${widget.idOfUser} is the id of user_____________________');
                    await _firestore
                        .collection('userData')
                        .doc(widget.idOfUser)
                        .update({
                      'phoneNumber': phoneNumber,
                      'firstName': firstName,
                      'lastName': lastName,
                      'description': description,
                      'occupation': occupation
                    });
                    Provider.of<ProviderData>(context, listen: false)
                        .updateUserData(phoneNumber, firstName, lastName,
                            occupation, description);
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Done!',
                    style: TextStyle(
                        fontFamily: 'Nunito', fontWeight: FontWeight.w600),
                  ),
                  color: kLightBlue2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
