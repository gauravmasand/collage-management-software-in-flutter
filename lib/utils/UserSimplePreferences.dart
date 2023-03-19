import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static String _keyCollageCode = "COLLAGE_CODE";
  static String _keyPosition = "POSITION";

  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  /// Collage code
  static Future setCollageCode(String value) async =>
      await _preferences.setString(_keyCollageCode, value);
  static String? getCollageCode() => _preferences.getString(_keyCollageCode);

  /// Position
  static Future setPosition(String value) async =>
      await _preferences.setString(_keyPosition, value);
  static String? getPosition() => _preferences.getString(_keyPosition);

  static Future deleteByKey(String value) async {
    await _preferences.remove(value);
  }

  static Future deleteAllData() async {
    await _preferences.clear();
  }

}