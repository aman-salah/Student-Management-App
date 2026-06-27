import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String tokenKey = "access_token";
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);
    print("TOKEN FROM STORAGE: $token");
    return token;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    print("token cleared");
  }
}
