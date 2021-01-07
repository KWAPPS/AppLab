
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connect_app/screens/forgot_password_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class PasswordResetFunctionality {
  void sendPasswordResetEmail() async {
    await _auth.sendPasswordResetEmail(email: emailForReset);
  }
}
