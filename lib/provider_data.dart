import 'package:flutter/cupertino.dart';
import 'package:connect_app/screens/timeline.dart';

class AppBarData extends ChangeNotifier {
  void showBottomNavigation() {
    showBottomNavigationBar = true;
    notifyListeners();
  }

  void hideBottomNavigation() {
    showBottomNavigationBar = false;
    notifyListeners();
  }
}
