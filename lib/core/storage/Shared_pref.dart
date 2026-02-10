import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized && _prefs != null) {
      return;
    }
    try {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    } catch (e) {
      // If initialization fails, we'll retry on next access
      _isInitialized = false;
      rethrow;
    }
  }

  static SharedPreferences? getPrefs() {
    return _prefs;
  }

  static Future<bool> setString(String key, String value) async {
    if (!_isInitialized || _prefs == null) {
      await init();
    }
    return await _prefs!.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    if (!_isInitialized || _prefs == null) {
      await init();
    }
    return await _prefs!.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<bool> remove(String key) async {
    if (!_isInitialized || _prefs == null) {
      await init();
    }
    return await _prefs!.remove(key);
  }

  static Future<bool> clear() async {
    if (!_isInitialized || _prefs == null) {
      await init();
    }
    return await _prefs!.clear();
  }
}
