import 'package:connect_app/screens/details_screen.dart';
import 'package:connect_app/screens/hire_me_screen.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/screens/welcome_screen.dart';

import 'package:connect_app/screens/login_screen.dart';
import 'package:connect_app/screens/home_screen.dart';
import 'package:connect_app/screens/register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        ),
      ),
      initialRoute: 'screens/home_screen.dart',
      routes: {
        'screens/details_screen.dart': (context) => DetailsScreen(),
        'screens/hire_me_screen.dart': (context) => HireMeScreen(),
        'screens/welcome_screen.dart': (context) => WelcomeScreen(),
        'screens/login_screen.dart': (context) => LoginScreen(),
        'screens/register_screen.dart': (context) => RegisterScreen(),
        'screens/home_screen.dart': (context) => HomeScreen(),
      },
    );
  }
}
