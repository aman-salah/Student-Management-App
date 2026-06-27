import 'package:frontend/core/models/classes_model.dart';
import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/features/class/data/class_service.dart';

class ClassRepository {
  final ClassService service;

  ClassRepository({required this.service});

  //get all classes
  Future<List<ClassesModel>> getAllClasses() {
    return service.getAllClasses();
  }

  //create class
  Future<ClassesModel> createClass(
    String subject,
    String classname,
    int semester,
  ) {
    return service.createClass(subject, classname, semester);
  }

  //delete a class
  Future<void> deleteClass(int classId) {
    return service.deleteClass(classId);
  }

  //add student to class
  Future<void> enrollStudent(int classId, String studid) {
    return service.enrollStudent(classId, studid);
  }

  //view students in class
  Future<List<StudentModel>> getStudentsInClass(int classId) {
    return service.getStudentsInClass(classId);
  }

  //remove student from class
  Future<void> removeStudentFromClass(int classId, String studentId) {
    return service.removeStudentFromClass(classId, studentId);
  }
}
