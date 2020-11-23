import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

String firstName;
String lastName;
String occupation;
String description;

String landscapeShotURL;

final _firestore = FirebaseFirestore.instance;

class InfoGetter extends StatefulWidget {
  @override
  _InfoGetterState createState() => _InfoGetterState();
}

class _InfoGetterState extends State<InfoGetter> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadProfileImageAndData(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
      (value) {
        String imageURL = value;
        print("Done uploading to storage: $imageURL");
        pushUserDataToCollection(imageURL);
      },
    );
  }

  void pushUserDataToCollection(String profileImageURL) {
    try {
      if (firstName != null) {
        _firestore.collection('userData').add({
          'firstName': firstName,
          'lastName': lastName,
          'description': description,
          'profileImageURL': profileImageURL,
          'occupation': occupation,
          'landscapeShotURL': landscapeShotURL,
          'timeStamp': FieldValue.serverTimestamp()
        });
        print('data added');
      } else {
        print('firstName was empty');
      }
    } catch (e) {
      print('something went wrong error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightPurple,
      child: Column(
        children: [
          Text('input details'),
          Material(
            child: TextField(
              onChanged: (value) {
                firstName = value;
              },
              decoration: InputDecoration(hintText: 'input first name'),
            ),
          ),
          Material(
            child: TextField(
              onChanged: (value) {
                lastName = value;
              },
              decoration: InputDecoration(hintText: 'input last name'),
            ),
          ),
          Material(
            child: TextField(
              onChanged: (value) {
                occupation = value;
              },
              decoration: InputDecoration(hintText: 'occupation'),
            ),
          ),
          Material(
            child: TextField(
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(hintText: 'description'),
            ),
          ),
          FlatButton(
            color: kDarkBlue2,
            onPressed: () {
              getImage();
              print('pressed');
            },
            child: Text('add profile image'),
          ),
          FlatButton(
            color: kDarkBlue2,
            onPressed: () {
              getImage();
              print('pressed');
            },
            child: Text('add a landscape image'),
          ),
          FlatButton(
            color: kDarkBlue2,
            onPressed: () async {
              await uploadProfileImageAndData(context);
            },
            child: Text('submit'),
          ),
          Container(
            height: 100,
            child: _image != null ? Image.file(_image) : Text('select image'),
          )
        ],
      ),
    );
  }
}
