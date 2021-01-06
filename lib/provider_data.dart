import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/screens/timeline.dart';

class ProviderData extends ChangeNotifier {
  void showBottomNavigation() {
    showBottomNavigationBar = true;
    notifyListeners();
  }

  void hideBottomNavigation() {
    showBottomNavigationBar = false;
    notifyListeners();
  }
}
