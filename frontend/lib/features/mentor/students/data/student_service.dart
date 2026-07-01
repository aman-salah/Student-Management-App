import 'dart:convert';

import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/core/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/core/constants/api_constants.dart';

class StudentService {
  Future<List<StudentModel>> get_all_students() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/students/get_all_students'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data
          .map<StudentModel>((student) => StudentModel.fromJson(student))
          .toList();
    }
    throw Exception("failed to load students");
  }

  Future<StudentModel> add_student(
    String name,
    String studid,
    String department,
    int age,
    String email,
    String contact,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/students/add_student'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'studid': studid,
        'department': department,
        'age': age,
        'email': email,
        'contact': contact,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return StudentModel.fromJson(data);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['detail']);
    }
  }

  Future<void> delete_student(String studid) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/students/delete_student/$studid'),
    );
    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['detail']);
    }
  }
}
