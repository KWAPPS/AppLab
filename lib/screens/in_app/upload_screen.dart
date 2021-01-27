import 'package:connect_app/screens/timeline.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/utilities/return_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

bool showUploadingSpinner;

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<Asset> images = List<Asset>();
  List<String> imageURLs = [];
  String _error;

  @override
  void initState() {
    showUploadingSpinner = false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent // status bar color
        ));
    super.initState();
  }

  Widget buildGridView() {
    if (images != null) {
      return Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(images.length, (index) {
                Asset asset = images[index];
                return AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                );
              }),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Divider(
              color: kDarkBlue2,
            ),
          ),
          images != null
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: RaisedButton(
                    color: kDarkBlue2,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () async {
                      setState(() {
                        showUploadingSpinner = true;
                        print('show upload spinner $showUploadingSpinner');
                      });
                      uploadPosts();
                    },
                    child: Text(
                      'upload',
                      style: TextStyle(fontFamily: 'Nunito'),
                    ),
                  ),
                )
              : null
        ],
      );
    } else
      return Container(height: 300, color: kLightPurple);
  }

  Future<void> loadAssets() async {
    imageURLs.clear();
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 6,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#07375D",
            actionBarTitle: "select photos",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#4E84B3",
          ));
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future uploadPosts() async {
    print('you have selected ${images.length} images');
    for (var image in images) {
      ByteData byteData =
          await image.getByteData(); // requestOriginal is being deprecated
      List<int> imageData = byteData.buffer.asUint8List();
      StorageReference ref = FirebaseStorage()
          .ref()
          .child(uuid.v4()); // To be aligned with the latest firebase API(4.0)
      StorageUploadTask uploadTask = ref.putData(imageData);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      await taskSnapshot.ref.getDownloadURL().then(
        (value) {
          imageURLs.add(value);
        },
      );
    }
    print('imageURLs: $imageURLs  before calling submit to firestore');
    submitToFirestore();

    setState(() {
      images.clear();
      showUploadingSpinner = false;
    });
    ReturnPopup(
        context: context,
        displayText: 'Successfully updated your portfolio!',
        builderCallback: (context) => Timeline()).triggerPopup();
  }

  void submitToFirestore() async {
    for (var imageURL in imageURLs) {
      _firestore.collection('posts').add({
        'email': _auth.currentUser.email,
        'imageURL': imageURL,
        'timeStamp': FieldValue.serverTimestamp()
      });
      print('____post Url added to firestore $imageURL');
    }

    print(
        'finished submitting to firestore_______ with imageURLs ${imageURLs.length}');
  }

  @override
  void dispose() {
    imageURLs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent // status bar color
        ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: kDarkBlue2,
        inAsyncCall: showUploadingSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'Add some images to your portfolio',
                  textAlign: TextAlign.center,
                  style: kSmallHeadingStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                child: RaisedButton(
                  color: kDarkBlue2,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: loadAssets,
                  child: Text(
                    'select images',
                    style: TextStyle(fontFamily: 'Nunito'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Divider(
                  color: kDarkBlue2,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: images != null ? buildGridView() : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
