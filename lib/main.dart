import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/home_screen.dart';
import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/login_screen.dart';
import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/register_screen.dart';
import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
