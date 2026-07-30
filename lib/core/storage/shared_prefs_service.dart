import 'package:shared_preferences/shared_preferences.dart';

/// Singleton wrapper for SharedPreferences.
class SharedPrefsService {
  SharedPrefsService._();
  static final SharedPrefsService _instance = SharedPrefsService._();
  static SharedPrefsService get instance => _instance;

  late final SharedPreferences _prefs;
  bool _initialized = false;

  /// Initializes the service. Must be called before any other method.
  static Future<void> init() async {
    instance._prefs = await SharedPreferences.getInstance();
    instance._initialized = true;
  }

  /// Returns true if initialization has been done.
  bool get isInitialized => _initialized;

  // ---- String ----
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // ---- Int ----
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // ---- Bool ----
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // ---- Double ----
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // ---- String List ----
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // ---- General ----
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}