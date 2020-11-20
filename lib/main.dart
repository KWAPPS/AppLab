import 'package:connect_app/screens/profile_screen.dart';
import 'package:connect_app/utilities/constants.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/details_screen.dart';
import 'screens/hire_me_screen.dart';
import 'package:flutter/material.dart';
import 'screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: kDarkBlue2,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        'screens/profile_screen.dart': (context) => ProfileScreen(),
        'screens/search_screen.dart': (context) => SearchScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        DetailsScreen.id: (context) => DetailsScreen(),
        HireMeScreen.id: (context) => HireMeScreen(),
      },
    );
  }
}
