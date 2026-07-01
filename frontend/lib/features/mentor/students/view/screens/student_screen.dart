import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/features/mentor/students/providers/student_provider.dart';
import 'package:frontend/features/mentor/students/view/widgets/add_student_sheet.dart';
import 'package:frontend/features/mentor/students/view/widgets/student_card.dart';
import 'package:frontend/features/mentor/students/view/widgets/student_search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StudentProvider>().get_all_students();
    });
  }

  Future<void> showDeleteDialog(String studid, String name) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Student"),
          content: Text("Are you sure you want to delete $name?"),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xff4F46E5)),
              ),
            ),

            TextButton(
              onPressed: () async {
                await context.read<StudentProvider>().delete_student(studid);

                if (!mounted) return;

                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Student deleted successfully")),
                );
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F8),
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Color(0xff4F46E5)),
          ),
        ],
        backgroundColor: const Color(0xFFF0F0F8),
        title: Text(
          'F I S A T',
          style: TextStyle(
            color: Color(0xff4F46E5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return AddStudentSheet();
            },
          );
        },
        backgroundColor: const Color(0xff4F46E5),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StudentSearchBar(
              placeholder: 'Search students using name or ID...',
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DIRECTORY (${studentProvider.students.length})",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.filter_list, size: 18, color: Color(0xff4F46E5)),
                    SizedBox(width: 4),
                    Text("Filter", style: TextStyle(color: Color(0xff4F46E5))),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            Expanded(
              child: studentProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : studentProvider.errorMessage != null
                  ? Center(child: Text(studentProvider.errorMessage!))
                  : ListView.builder(
                      itemCount: studentProvider.filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = studentProvider.filteredStudents[index];

                        return StudentCard(
                          name: student.name,
                          studentId: student.studid,
                          age: student.age,
                          email: student.email,
                          contact: student.contact,
                          onLongPress: () {
                            showDeleteDialog(student.studid, student.name);
                          },
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
