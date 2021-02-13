import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/screens/in_app/edit_profile.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/provider_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

String newImageURL;
FirebaseFirestore _firestore = Firestore.instance;

class ConfirmImageUpload extends StatelessWidget {
  var image;
  String pathToUpdate;
  String userID;

  ConfirmImageUpload({this.image, this.pathToUpdate, this.userID});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.file(image)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            RaisedButton(
              onPressed: () {
                void pushProductDataToCollection() {
                  if (newImageURL != null) {
                    _firestore
                        .collection('userData')
                        .doc(userID)
                        .update({pathToUpdate: newImageURL});
                    Provider.of<ProviderData>(context, listen: false)
                        .updateProfileImageURL(newImageURL);
                    Provider.of<ProviderData>(context, listen: false)
                        .updateCoverImageURL(newImageURL);
                  } else {
                    print('newImageURL was empty');
                  }
                }

                Future uploadImageToFirebase(BuildContext context) async {
                  print(
                      'called uploadFile.UploadToFirebase _________________and image is $image  _____________');
                  String fileName = basename(image.path);
                  StorageReference firebaseStorageRef =
                      FirebaseStorage.instance.ref().child('$fileName');
                  StorageUploadTask uploadTask =
                      firebaseStorageRef.putFile(image);
                  StorageTaskSnapshot taskSnapshot =
                      await uploadTask.onComplete;
                  taskSnapshot.ref.getDownloadURL().then(
                    (value) {
                      newImageURL = value;
                      print("Done uploading to storage: $newImageURL");
                      pushProductDataToCollection();
                    },
                  );
                }

                uploadImageToFirebase(context);

                Navigator.pop(context);
              },
              padding: EdgeInsets.all(5),
              child: Text(
                'Upload',
                style: TextStyle(
                    fontFamily: 'Nunito', fontWeight: FontWeight.w600),
              ),
              color: kLightBlue2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            )
          ],
        ),
      ),
    );
  }
}
