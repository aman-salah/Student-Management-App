import 'package:flutter/material.dart';
import 'package:frontend/core/models/classes_model.dart';
import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/features/student/class/data/student_class_repository.dart';

class StudentClassProvider extends ChangeNotifier {
  final StudentClassRepository repository;

  StudentClassProvider({required this.repository});
  final Set<String> _selectedStudents = {};
  Set<String> get selectedStudents => _selectedStudents;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ClassesModel? _currentClass;
  ClassesModel? get currentClass => _currentClass;

  List<ClassesModel> _classes = [];
  List<ClassesModel> get classes => _classes;

  List<ClassesModel> _filteredClasses = [];
  List<ClassesModel> get filteredClasses => _filteredClasses;

  List<StudentModel> _classStudents = [];
  List<StudentModel> get classStudents => _classStudents;

  //get all classes
  Future<void> getAllClasses() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _classes = await repository.getAllClasses();
      _filteredClasses = List.from(_classes);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //search bar logic
  void get_filtered_classes(String query) {
    if (query.isEmpty) {
      _filteredClasses = List.from(_classes);
    } else {
      _filteredClasses = _classes.where((room) {
        final subject = room.subject.toLowerCase();
        final classname = room.class_name.toLowerCase();
        final input = query.toLowerCase();
        return subject.contains(input) || classname.contains(input);
      }).toList();
    }
    notifyListeners();
  }

  //class details
  Future<void> loadClassDetails(int classId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _currentClass = _classes.firstWhere((c) => c.class_id == classId);

      _classStudents = await repository.getStudentsInClass(classId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //get students in a class
  Future<void> getStudentsInClass(int classId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _classStudents = await repository.getStudentsInClass(classId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
