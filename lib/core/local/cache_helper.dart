import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String _lastCityKey = 'last_city';

  // Save the last searched city
  static Future<void> saveLastCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastCityKey, city);
    print("city saved locally: $city");
  }

  // Retrieve the last searched city
  static Future<String?> getLastCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final city = prefs.getString(_lastCityKey);
    print('Retrieved last city: $city');
    return prefs.getString(_lastCityKey);
  }
}
