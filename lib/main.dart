import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: 'welcome_screen.dart',
      routes: {
        'home_screen.dart': (context) => HomeScreen(),
        'login_screen.dart': (context) => LoginScreen(),
        'welcome_screen.dart': (context) => WelcomeScreen()
      },
    );
  }
}
