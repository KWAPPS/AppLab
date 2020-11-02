import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';
import 'details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))))),
      initialRoute: 'details_screen.dart',
      routes: {
        'details_screen.dart': (context) => DetailsScreen(),
        'home_screen.dart': (context) => HomeScreen(),
        'login_screen.dart': (context) => LoginScreen(),
        'welcome_screen.dart': (context) => WelcomeScreen()
      },
    );
  }
}
