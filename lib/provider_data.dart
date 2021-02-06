import 'package:connect_app/screens/in_app/edit_profile.dart';
import 'package:connect_app/screens/in_app/my_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/screens/timeline.dart';
import 'package:connect_app/custom_widgets/person_info_card.dart';

class ProviderData extends ChangeNotifier {
  void showBottomNavigation() {
    showBottomNavigationBar = true;
    notifyListeners();
  }

  void toggleLoadingOnEditProfile() {
    toggleSpin = !toggleSpin;
    notifyListeners();
  }

  void updateProfileImageURL(var profileImageURL) {
    userProfileImageURL = profileImageURL;
    myProfileImageURL = profileImageURL;
    toggleSpin = false;
    notifyListeners();
  }

  void updateCoverImageURL(var coverImageURL) {
    userCoverImageURL = coverImageURL;
    notifyListeners();
  }

  void updateStarWidgetInCard1(
      double numberOfStars, PersonInfoCard1 infoCard1) {
    infoCard1.numberOfStarsInTheWidget = numberOfStars;
    print('updating star widget in card');
    notifyListeners();
  }

  void updateStarWidgetInCard2(
      double numberOfStars, PersonInfoCard2 infoCard2) {
    infoCard2.numberOfStarsInWidget = numberOfStars;
    notifyListeners();
  }

  void hideBottomNavigation() {
    showBottomNavigationBar = false;
    notifyListeners();
  }
}
