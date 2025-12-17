import 'package:shared_preferences/shared_preferences.dart';

class SharedCheckHelper {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static dynamic getValue(String key) {
    return _prefs.get(key);
  }

  static Future<void> setValue(String key, dynamic value) async {
    if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw Exception("Type not supported");
    }
  }

  static const String keyIsLogin = 'isLogin';
  static const String keyUserId = 'userId';
  static const String keyUserName = 'userName';
  static const String keyUserEmail = 'userEmail';
  static const String keyUserAvatarId = 'userAvatarId';
  static const String keyIsOnBoarding= 'isOnBoarding';

  // User Data
  static Future<void> setUserData({
    required String id,
    required String name,
    required String email,
    String? avatarId,
  }) async {
    await setValue(keyUserId, id);
    await setValue(keyUserName, name);
    await setValue(keyUserEmail, email);
    if (avatarId != null) {
      await setValue(keyUserAvatarId, avatarId);
    }
  }

  static Map<String, String?> getUserData() {
    return {
      'id': getValue(keyUserId),
      'name': getValue(keyUserName),
      'email': getValue(keyUserEmail),
      'avatarId': getValue(keyUserAvatarId),
    };
  }

  static Future<void> clearUserData() async {
    await _prefs.remove(keyUserId);
    await _prefs.remove(keyUserName);
    await _prefs.remove(keyUserEmail);
    await _prefs.remove(keyUserAvatarId);
  }
}