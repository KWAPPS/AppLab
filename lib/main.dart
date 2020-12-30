import 'dart:developer';
import 'utilities/data_controller.dart';
import 'package:connect_app/provider_data.dart';
import 'package:connect_app/screens/timeline.dart';
import 'package:connect_app/screens/in_app/profile_screen.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/screens/in_app/info_getter.dart';
import 'package:provider/provider.dart';
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
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    return ChangeNotifierProvider(
      create: (_) => AppBarData(),
      child: MaterialApp(
        // theme: ThemeData.dark().copyWith(
        //   primaryColor: kDarkBlue2,
        //   buttonBarTheme: ButtonBarThemeData(
        //     alignment: MainAxisAlignment.center,
        //   ),
        //   bottomSheetTheme: BottomSheetThemeData(
        //     backgroundColor: Colors.transparent,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.vertical(
        //         top: Radius.circular(20),
        //       ),
        //     ),
        //   ),
        // ),
        initialRoute: 'screen/timeline.dart',
        routes: {
          'screen/timeline.dart': (context) => Timeline(),
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
      ),
    );
  }
}
