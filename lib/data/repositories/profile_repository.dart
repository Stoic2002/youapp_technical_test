import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youapp_technical_test/core/api/api.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';
import 'package:youapp_technical_test/data/repositories/token_repository.dart';

class ProfileRepository {
  final http.Client _client = http.Client();
  final TokenRepository tokenRepo = TokenRepository();

  Future<Map<String, String>> _getHeaders() async {
    final token = await tokenRepo.getToken();
    return {
      'Content-Type': 'application/json',
      'x-access-token': token ?? '',
    };
  }

  Future<ProfileModel> createProfile(ProfileModel profile) async {
    final headers = await _getHeaders();
    final response = await _client.post(
      Uri.parse('$baseUrl/createProfile'),
      headers: headers,
      body: jsonEncode({
        'name': profile.name,
        'birthday': profile.birthday,
        'height': profile.height,
        'weight': profile.weight,
        'interests': []
      }),
    );

    if (response.statusCode == 200) {
      return profile;
    } else {
      throw Exception('Failed to create profile: ${response.body}');
    }
  }

  Future<ProfileModel> getProfile() async {
    final headers = await _getHeaders();
    final response = await _client.get(
      Uri.parse('$baseUrl/getProfile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return ProfileModel.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to get profile: ${response.body}');
    }
  }

  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    final headers = await _getHeaders();
    final response = await _client.put(
      Uri.parse('$baseUrl/updateProfile'),
      headers: headers,
      body: jsonEncode({
        'name': profile.name,
        'birthday': profile.birthday,
        'height': profile.height,
        'weight': profile.weight,
        'interests': profile.interests
      }),
    );

    if (response.statusCode == 200) {
      return profile;
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }
}
