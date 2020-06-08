import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_service.dart';
import '../locator.dart';

class KeyValueServiceSharedPrefs implements KeyValueService {
  @override
  Future<bool> clear() async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.clear();
  }

  @override
  bool containsKey(String key) {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.containsKey(key);
  }

  @override
  dynamic get(String key) {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.get(key);
  }

  @override
  bool getBool(String key) {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.getBool(key);
  }

  @override
  double getDouble(String key) {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.getDouble(key);
  }

  @override
  int getInt(String key) {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.getInt(key);
  }

  @override
  Set<String> getKeys() {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.getKeys();
  }

  @override
  String getString(String key) {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.getString(key);
  }

  @override
  List<String> getStringList(String key) {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return sharedPrefs.getStringList(key);
  }

  @override
  Future<void> reload() async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.reload();
  }

  @override
  Future<bool> remove(String key) async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.remove(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.setBool(key, value);
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.setDouble(key, value);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.setInt(key, value);
  }

  @override
  Future<bool> setString(String key, String value) async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.setString(key, value);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    SharedPreferences sharedPrefs = locator<SharedPreferences>();
    return await sharedPrefs.setStringList(key, value);
  }
}
