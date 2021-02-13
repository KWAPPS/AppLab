import 'package:connect_app/screens/in_app/edit_profile.dart';
import 'package:connect_app/screens/in_app/my_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:connect_app/screens/timeline.dart';
import 'package:connect_app/custom_widgets/person_info_card.dart';
import 'package:connect_app/main.dart';

class ProviderData extends ChangeNotifier {
  void showBottomNavigation() {
    showBottomNavigationBar = true;
    notifyListeners();
  }

  void updateRatingOnMyProfile(double currentUserRating) {
    myRating = currentUserRating;
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

  void updateUserData(String userPhoneNumber, String userFirstName,
      String userLastName, String userOccupation, String userDescription) {
    phoneNumber = userPhoneNumber;
    firstName = userFirstName;
    lastName = userLastName;
    occupation = userOccupation;
    description = userDescription;
    myProfileName = '${capitalize(userFirstName)} ${capitalize(userLastName)}';
    myProfileOccupation = userOccupation;
    toggleSpin = false;
    print('updated user data');
    print('new name is $userFirstName');
    notifyListeners();
  }

  void updateCoverImageURL(var coverImageURL) {
    userCoverImageURL = coverImageURL;
    toggleSpin = false;
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
