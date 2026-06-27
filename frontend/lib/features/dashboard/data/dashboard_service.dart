import 'dart:convert';

import 'package:frontend/core/constants/api_constants.dart';
import 'package:frontend/core/models/dashboard_model.dart';
import 'package:frontend/core/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  Future<DashboardModel> getDashboardStats() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/dashboard/stats'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DashboardModel.fromJson(data);
    }
    throw Exception("Failed to load stats");
  }
}
