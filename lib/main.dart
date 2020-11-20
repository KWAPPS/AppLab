import 'file:///C:/Users/Peter%20Oketta/AndroidStudioProjects/AppLab/lib/screens/in_app/profile_screen.dart';
import 'package:connect_app/utilities/constants.dart';

import 'screens/splash_screen.dart';
import 'screens/in_app/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/in_app/details_screen.dart';
import 'screens/in_app/hire_me_screen.dart';
import 'package:flutter/material.dart';
import 'screens/in_app/search_screen.dart';

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
      initialRoute: RegisterScreen.id,
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
