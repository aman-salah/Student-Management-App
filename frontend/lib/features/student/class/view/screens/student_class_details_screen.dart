import 'package:flutter/material.dart';

import 'package:frontend/features/student/class/providers/student_class_provider.dart';

import 'package:provider/provider.dart';

class StudentClassDetailsScreen extends StatefulWidget {
  final String classId;

  const StudentClassDetailsScreen({super.key, required this.classId});

  @override
  State<StudentClassDetailsScreen> createState() =>
      _StudentClassDetailScreenState();
}

class _StudentClassDetailScreenState extends State<StudentClassDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentClassProvider>().loadClassDetails(
        int.parse(widget.classId),
      );
    });
  }

  @override
  void didUpdateWidget(covariant StudentClassDetailsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.classId != widget.classId) {
      context.read<StudentClassProvider>().loadClassDetails(
        int.parse(widget.classId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentClassProvider = context.watch<StudentClassProvider>();
    final currentClass = studentClassProvider.currentClass;
    print(currentClass);

    if (currentClass == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0F8),
        elevation: 0,
        title: const Text(
          "Class Details",
          style: TextStyle(
            color: Color(0xFF4F46E5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentClass.subject,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Class Name : ${currentClass.class_name.toUpperCase()}'),
                  const SizedBox(height: 5),
                  Text(
                    'Students: ${studentClassProvider.classStudents.length}',
                  ),
                  const SizedBox(height: 5),
                  Text('Semester: ${currentClass.semester}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Students",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: studentClassProvider.classStudents.isEmpty
                  ? const Center(child: Text("No students enrolled yet"))
                  : ListView.builder(
                      itemCount: studentClassProvider.classStudents.length,
                      itemBuilder: (context, index) {
                        final student =
                            studentClassProvider.classStudents[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(16),

                          child: Card(
                            shadowColor: Colors.grey[200],
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(student.name[0].toUpperCase()),
                              ),
                              title: Text(student.name),
                              subtitle: Text(student.email),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
