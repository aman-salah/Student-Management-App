import 'dart:convert';

import 'package:frontend/core/constants/api_constants.dart';
import 'package:frontend/core/models/profile_model.dart';
import 'package:frontend/core/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<ProfileModel> getProfile() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/profile/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProfileModel.fromJson(data);
    }
    throw Exception("Failed to load stats");
  }
}
