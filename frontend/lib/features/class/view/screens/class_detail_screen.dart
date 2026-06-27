import 'package:flutter/material.dart';
import 'package:frontend/features/class/providers/class_provider.dart';
import 'package:frontend/features/class/view/widgets/add_students_sheet.dart';
import 'package:provider/provider.dart';

class ClassDetailScreen extends StatefulWidget {
  final int index;
  const ClassDetailScreen({super.key, required this.index});

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ClassProvider>().getStudentsInClass(
        context.read<ClassProvider>().selectedClass!.class_id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final classProvider = context.watch<ClassProvider>();
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4F46E5),
        onPressed: () {
          _showAddStudentsSheet(context);
        },
        child: const Icon(Icons.person_add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// CLASS INFO CARD
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
                    classProvider.classes[widget.index].subject,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Class Name : ${classProvider.classes[widget.index].class_name.toUpperCase()}',
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Students: ${(classProvider.classStudents.length).toString()}',
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Semester: ${classProvider.classes[widget.index].semester}',
                  ),
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
              child: classProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : classProvider.classStudents.isEmpty
                  ? const Center(child: Text("No students enrolled yet"))
                  : ListView.builder(
                      itemCount: classProvider.classStudents.length,
                      itemBuilder: (context, index) {
                        final student = classProvider.classStudents[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onLongPress: () =>
                              showDeleteDialog(student.studid, student.name),
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

  void _showAddStudentsSheet(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return AddStudentsSheet();
      },
    );
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
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xff4F46E5)),
              ),
            ),

            TextButton(
              onPressed: () async {
                final classProvider = context.read<ClassProvider>();
                await classProvider.removeStudentFromClass(
                  classProvider.selectedClass!.class_id,
                  studid,
                );

                if (!mounted) return;

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Student removed successfully")),
                );
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
