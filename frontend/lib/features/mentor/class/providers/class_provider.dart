import 'package:flutter/material.dart';
import 'package:frontend/core/models/classes_model.dart';
import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/features/mentor/class/data/class_repository.dart';

class ClassProvider extends ChangeNotifier {
  final ClassRepository repository;

  ClassProvider({required this.repository});
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

  //create a class
  Future<void> createClass(
    String subject,
    String classname,
    int semester,
  ) async {
    final newClass = await repository.createClass(subject, classname, semester);
    _errorMessage = errorMessage;
    _classes.add(newClass);
    _filteredClasses.add(newClass);
    notifyListeners();
  }

  //add student to a class
  Future<void> enrollStudent(int classId, String studentId) async {
    await repository.enrollStudent(classId, studentId);

    await loadClassDetails(classId);
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

  //remove student from class
  Future<void> removeStudentFromClass(int classId, String studid) async {
    await repository.removeStudentFromClass(classId, studid);

    await loadClassDetails(classId);
  }

  //student present in class logic
  void toggleStudentSelection(String studid) {
    if (_selectedStudents.contains(studid)) {
      _selectedStudents.remove(studid);
    } else {
      _selectedStudents.add(studid);
    }
    notifyListeners();
  }

  void clearSelectedStudents() {
    _selectedStudents.clear();
    notifyListeners();
  }
}
