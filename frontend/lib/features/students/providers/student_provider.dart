import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/features/students/data/student_repository.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository repository;

  StudentProvider({required this.repository});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;

  List<StudentModel> _filteredStudents = [];
  List<StudentModel> get filteredStudents => _filteredStudents;

  String _selectedDepartment = "CSE";
  List<DropdownMenuItem> departments = [
    DropdownMenuItem(value: "CSE", child: Text("CSE")),
    DropdownMenuItem(value: "MECH", child: Text("MECH")),
    DropdownMenuItem(value: "ECE", child: Text("ECE")),
    DropdownMenuItem(value: "EEE", child: Text("EEE")),
    DropdownMenuItem(value: "AI", child: Text("AI")),
  ];
  String get selectedDepartment => _selectedDepartment;

  Future<void> get_all_students() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      _students = await repository.get_all_students();
      _filteredStudents = List.from(_students);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void get_filtered_students(String query) {
    if (query.isEmpty) {
      _filteredStudents = List.from(_students);
    } else {
      _filteredStudents = _students.where((student) {
        final name = student.name.toLowerCase();
        final studid = student.studid.toLowerCase();
        final input = query.toLowerCase();
        return name.contains(input) || studid.contains(input);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> add_student(
    String name,
    String studid,
    String department,
    int age,
    String email,
    String contact,
  ) async {
    _errorMessage = null;
    notifyListeners();
    final new_student = await repository.add_student(
      name,
      studid,
      department,
      age,
      email,
      contact,
    );
    _errorMessage = errorMessage;
    _students.add(new_student);
    _filteredStudents.add(new_student);
    notifyListeners();
  }

  Future<void> delete_student(String studid) async {
    await repository.delete_student(studid);
    _students.removeWhere((student) => student.studid == studid);
    _filteredStudents.removeWhere((student) => student.studid == studid);
    notifyListeners();
  }

  void setDepartment(String department) {
    _selectedDepartment = department;
    notifyListeners();
  }
}
