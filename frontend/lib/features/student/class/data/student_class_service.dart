import 'dart:convert';
import 'package:frontend/core/constants/api_constants.dart';
import 'package:frontend/core/models/classes_model.dart';
import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/core/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StudentClassService {
  //get all classes
  Future<List<ClassesModel>> getAllClasses() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/classes/all'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data
          .map<ClassesModel>((room) => ClassesModel.fromJson(room))
          .toList();
    }
    throw Exception("Failed to load classes");
  }

  //view students in a class
  Future<List<StudentModel>> getStudentsInClass(int classId) async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/classes/$classId/students'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data as List)
          .map((student) => StudentModel.fromJson(student))
          .toList();
    }

    throw Exception('Failed to load students');
  }
}
