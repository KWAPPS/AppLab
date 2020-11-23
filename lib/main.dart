import 'package:connect_app/screens/in_app/profile_screen.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/screens/in_app/info_getter.dart';
import 'screens/splash_screen.dart';
import 'screens/in_app/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/in_app/details_screen.dart';
import 'screens/in_app/hire_me_screen.dart';
import 'package:flutter/material.dart';
import 'screens/in_app/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
      initialRoute: HomeScreen.id,
      routes: {
        'screens/in_app/info_getter.dart': (context) => InfoGetter(),
        'screens/in_app/profile_screen.dart': (context) => ProfileScreen(),
        'screens/in_app/search_screen.dart': (context) => SearchScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        // DetailsScreen.id: (context) => DetailsScreen(),
        HireMeScreen.id: (context) => HireMeScreen(),
      },
    );
  }
}
