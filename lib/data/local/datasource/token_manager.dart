import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _keyAuthToken = "auth_token";
  final SharedPreferences _sharedPreferences;

  TokenManager(this._sharedPreferences);

  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString(_keyAuthToken, token);
  }

  Future<String?> getToken() async {
    return _sharedPreferences.getString(_keyAuthToken);
  }

  Future<void> clearToken() async {
    await _sharedPreferences.remove(_keyAuthToken);
  }
}