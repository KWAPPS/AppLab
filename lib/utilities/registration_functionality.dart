import 'package:connect_app/screens/splash_screen.dart';
import 'package:connect_app/utilities/return_popup.dart';
import 'package:connect_app/screens/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


//TODO think about if it is really necessary to initialize all the fields for a new user, considering they might never be interested in creating a porfolio.

FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class RegistrationFunctionality {
  void registerUser(context, Function setState) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await newUser.user.sendEmailVerification();
      await _auth.signOut();

      _firestore.collection('userData').add({
        'email': email,
        'profileImageURL':
            'https://images.unsplash.com/photo-1530305408560-82d13781b33a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80',
        'profilePageColor': '1',
        'coverImageURL':
            'https://images.unsplash.com/photo-1530305408560-82d13781b33a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80',
        'phoneNumber': '+256',
        'description': 'your description',
        'lastName': 'your last name',
        'firstName': 'your first name',
        'occupation': 'what you do'
      });

      return await ReturnPopup(
          context: context,
          displayText:
              'check your email and click the link to verify your address, then sign in!',
          builderCallback: (context) => SplashScreen()).triggerPopup();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Email Already In Use');

        ReturnPopup(
            context: context,
            displayText: 'Email is already is use',
            builderCallback: (context) => RegisterScreen()).triggerPopup();
      }

      if (e.code == 'weak-password') {
        print('password is too weak');
        ReturnPopup(
            context: context,
            displayText: 'weak password',
            builderCallback: (context) => RegisterScreen()).triggerPopup();
      } else {
        ReturnPopup(
            context: context,
            displayText: 'something went wrong',
            builderCallback: (context) => RegisterScreen()).triggerPopup();
      }
    } catch (e) {
      print(e);
      ReturnPopup(
          context: context,
          displayText: 'oops!🙊 something went wrong',
          builderCallback: (context) => RegisterScreen()).triggerPopup();
    }
  }
}
