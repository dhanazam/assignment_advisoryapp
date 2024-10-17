import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  Future<bool?> putString(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }
}
