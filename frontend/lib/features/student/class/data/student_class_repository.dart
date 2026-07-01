import 'package:frontend/core/models/classes_model.dart';
import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/features/student/class/data/student_class_service.dart';

class StudentClassRepository {
  final StudentClassService service;

  StudentClassRepository({required this.service});

  //get all classes
  Future<List<ClassesModel>> getAllClasses() {
    return service.getAllClasses();
  }

  //view students in class
  Future<List<StudentModel>> getStudentsInClass(int classId) {
    return service.getStudentsInClass(classId);
  }
}
