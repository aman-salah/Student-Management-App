import 'dart:convert';

import 'package:frontend/core/constants/api_constants.dart';
import 'package:frontend/core/models/classes_model.dart';
import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/core/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ClassService {
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

  //create a class
  Future<ClassesModel> createClass(
    String subject,
    String classname,
    int semester,
  ) async {
    final token = await TokenStorage.getToken();
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/classes/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'subject': subject,
        'classname': classname,
        'semester': semester,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ClassesModel.fromJson(data);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['detail']);
    }
  }

  //Delete a class
  Future<void> deleteClass(int classId) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/classes/delete'),
    );
    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['detail']);
    }
  }

  //add student to class
  Future<void> enrollStudent(int classId, String studid) async {
    final token = TokenStorage.getToken();
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/classes/enroll'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'class_id': classId, 'student_id': studid}),
    );
    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['detail']);
    }
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

  //remove student from a class
  Future<void> removeStudentFromClass(int classId, String studentId) async {
    final token = await TokenStorage.getToken();

    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/classes/$classId/student/$studentId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['detail']);
    }
  }
}
