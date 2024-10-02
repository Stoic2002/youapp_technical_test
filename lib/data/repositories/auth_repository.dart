import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youapp_technical_test/core/api/api.dart';
import 'package:youapp_technical_test/data/models/auth_model.dart';
import 'package:youapp_technical_test/data/repositories/token_repository.dart';

class AuthRepository {
  final http.Client _client = http.Client();
  TokenRepository tokenRepo = TokenRepository();

  Future<String> register(AuthModel authModel) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': authModel.email,
        'username': authModel.userName,
        'password': authModel.password,
      }),
    );

    if (response.statusCode == 201) {
      return 'Registration successful';
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<String> login(AuthModel authModel) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': authModel.email,
        'username': authModel.userName,
        'password': authModel.password,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final token = responseData['access_token'];
      await tokenRepo.saveToken(token);
      return token;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> logout() async {
    await tokenRepo.logout();
  }

  Future<bool> isLoggedIn() async {
    final token = await tokenRepo.getToken();
    debugPrint('Checking login status. Token: ${token ?? 'No token found'}');
    return token != null;
  }
}
