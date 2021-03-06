import 'package:connect_app/provider_data.dart';
import 'package:connect_app/screens/in_app/edit_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/screens/in_app/home_screen.dart';
import 'package:connect_app/screens/splash_screen.dart';
import 'package:connect_app/screens/timeline.dart';
import 'package:connect_app/screens/in_app/profile_screen.dart';
import 'package:connect_app/screens/register_screen.dart';
import 'package:connect_app/screens/login_screen.dart';
import 'package:connect_app/screens/welcome_screen.dart';
import 'package:connect_app/screens/in_app/hire_me_screen.dart';
import 'package:connect_app/screens/in_app/search_screen.dart';
import 'package:connect_app/push_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

String capitalize(String string) {
  if (string == null) {
    throw ArgumentError.notNull('string');
  }

  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    return ChangeNotifierProvider(
      create: (_) => ProviderData(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          buttonBarTheme: ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
          ),
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
          'screen/timeline.dart': (context) => Timeline(),
          'screens/in_app/profile_screen.dart': (context) => ProfileScreen(),
          'screens/in_app/search_screen.dart': (context) => SearchScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          SplashScreen.id: (context) => SplashScreen(),
          HireMeScreen.id: (context) => HireMeScreen(),
        },
      ),
    );
  }
}
