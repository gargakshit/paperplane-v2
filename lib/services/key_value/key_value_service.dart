abstract class KeyValueService {
  Future<bool> clear();
  bool containsKey(String key);
  dynamic get(String key);
  bool getBool(String key);
  double getDouble(String key);
  int getInt(String key);
  Set<String> getKeys();
  String getString(String key);
  List<String> getStringList(String key);
  Future<void> reload();
  Future<bool> remove(String key);
  Future<bool> setBool(String key, bool value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setInt(String key, int value);
  Future<bool> setString(String key, String value);
  Future<bool> setStringList(String key, List<String> value);
}
