import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_technical_test/core/secret/secret_key.dart';

class TokenRepository {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(authToken, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authToken);
    return token;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await prefs.remove(authToken);
    debugPrint('token remove $res');
  }
}
