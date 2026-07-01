import 'package:flutter/material.dart';
import 'package:frontend/features/mentor/class/providers/class_provider.dart';
import 'package:frontend/features/mentor/students/providers/student_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddStudentsSheet extends StatefulWidget {
  const AddStudentsSheet({super.key});

  @override
  State<AddStudentsSheet> createState() => _AddStudentsSheetState();
}

class _AddStudentsSheetState extends State<AddStudentsSheet> {
  final studentController = TextEditingController();
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StudentProvider>().get_all_students();
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    final classProvider = context.watch<ClassProvider>();
    final currentClass = classProvider.currentClass;

    if (currentClass == null) {
      return const SizedBox.shrink();
    }

    final classId = currentClass.class_id;
    final availableStudents = studentProvider.students.where((student) {
      return !classProvider.classStudents.any(
        (enrolled) => enrolled.studid == student.studid,
      );
    }).toList();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 55),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Add Students",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 15),

            TextField(
              controller: studentController,
              decoration: InputDecoration(
                hintText: "Search students",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                studentProvider.get_filtered_students(studentController.text);
              },
            ),

            const SizedBox(height: 15),

            Expanded(
              child: studentProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : studentProvider.errorMessage != null
                  ? Center(child: Text(studentProvider.errorMessage!))
                  : ListView.builder(
                      itemCount: availableStudents.length,

                      itemBuilder: (context, index) {
                        final student = availableStudents[index];

                        return CheckboxListTile(
                          value: classProvider.selectedStudents.contains(
                            student.studid,
                          ),
                          title: Text(student.name),
                          subtitle: Text(student.email),
                          onChanged: (value) {
                            classProvider.toggleStudentSelection(
                              student.studid,
                            );
                          },
                        );
                      },
                    ),
            ),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {
                  for (final studid in classProvider.selectedStudents) {
                    await classProvider.enrollStudent(classId, studid);
                  }

                  classProvider.clearSelectedStudents();

                  await classProvider.loadClassDetails(classId);

                  if (!mounted) return;

                  context.pop();
                },

                child: Text(
                  "Add Selected Students"
                  "(${classProvider.selectedStudents.length})",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
