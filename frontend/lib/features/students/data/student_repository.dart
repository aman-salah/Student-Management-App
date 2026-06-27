import 'package:frontend/core/models/student_model.dart';
import 'package:frontend/features/students/data/student_service.dart';

class StudentRepository {
  final StudentService service;

  StudentRepository({required this.service});

  Future<List<StudentModel>> get_all_students() {
    return service.get_all_students();
  }

  Future<StudentModel> add_student(
    String name,
    String studid,
    String department,
    int age,
    String email,
    String contact,
  ) {
    return service.add_student(name, studid, department, age, email, contact);
  }

  Future<void> delete_student(String studid) {
    return service.delete_student(studid);
  }
}
