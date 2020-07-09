import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static saveUserData(Map<String, dynamic> data) async {
    SharedPreferences preferences = await _prefs;
    data.forEach((key, value) {
      preferences.setString(key, value);
    });
  }
}
