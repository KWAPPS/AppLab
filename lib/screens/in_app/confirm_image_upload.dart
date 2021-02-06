import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/screens/in_app/edit_profile.dart';

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
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(image),
            FlatButton(
              child: Text('confirm upload'),
              color: Colors.blue,
              onPressed: () {
                void pushProductDataToCollection() {
                  if (newImageURL != null) {
                    _firestore
                        .collection('userData')
                        .doc(userID)
                        .update({pathToUpdate: newImageURL});
                    Provider.of<ProviderData>(context, listen: false)
                        .updateProfileImageURL(newImageURL);
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
            )
          ],
        ),
      ),
    );
  }
}
