import 'package:flutter/material.dart';
import 'package:frontend/features/students/providers/student_provider.dart';
import 'package:provider/provider.dart';

class AddStudentSheet extends StatefulWidget {
  const AddStudentSheet({super.key});

  @override
  State<AddStudentSheet> createState() => _AddStudentSheetState();
}

class _AddStudentSheetState extends State<AddStudentSheet> {
  final nameController = TextEditingController();
  final studentIdController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    studentIdController.dispose();
    ageController.dispose();
    emailController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Add Student",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: studentIdController,
              decoration: InputDecoration(
                labelText: "Student ID",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            DropdownButtonFormField(
              initialValue: studentProvider.selectedDepartment,
              items: studentProvider.departments,
              onChanged: (value) {
                studentProvider.setDepartment(value);
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: contactController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Contact",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  studentProvider.add_student(
                    nameController.text,
                    studentIdController.text,
                    studentProvider.selectedDepartment,
                    int.parse(ageController.text),
                    emailController.text,
                    contactController.text,
                  );
                  if (studentProvider.errorMessage != null) {
                    Text(studentProvider.errorMessage!);
                  } else {
                    studentProvider.get_all_students();
                    Navigator.pop(context);
                  }
                  // provider call later
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4F46E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add Student",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
