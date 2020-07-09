import 'dart:math';

import 'package:girixscanner/www/grixcode/com/models/user.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/connected_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/sharedData/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends ConnectedModel {
  void saveToDevice({String email, String username}) {
    final String userId =
        Random().nextInt(50).toString() + "" + email + " " + username;
    SharedPref.saveUserData(
        {"userName": username, "userEmail": email, "userId": userId});
    user = User(name: username, id: userId, email: email);
    notifyListeners();
  }

  void autoAuthenticate() async {
    try {
      print("Auto Authenticating Started ....");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final username = prefs.getString("userName");
      final email = prefs.getString("userEmail");
      final String id = prefs.getString("userId");
      if (id != null) {
        user = User(email: email, id: id, name: username);
        notifyListeners();
      } else {
        print("User is Not Logged In Currently");
      }
    } catch (e) {
      print(e);
    }
  }
}
