import 'package:flutter/material.dart';
import 'package:frontend/features/mentor/class/providers/class_provider.dart';
import 'package:frontend/features/mentor/class/view/widgets/add_students_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ClassDetailScreen extends StatefulWidget {
  final String classId;

  const ClassDetailScreen({super.key, required this.classId});

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClassProvider>().loadClassDetails(int.parse(widget.classId));
    });
  }

  @override
  void didUpdateWidget(covariant ClassDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.classId != widget.classId) {
      context.read<ClassProvider>().loadClassDetails(int.parse(widget.classId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final classProvider = context.watch<ClassProvider>();
    final currentClass = classProvider.currentClass;

    if (classProvider.isLoading || currentClass == null) {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4F46E5),
        onPressed: () => _showAddStudentsSheet(context),
        child: const Icon(Icons.person_add),
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
                  Text('Students: ${classProvider.classStudents.length}'),
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
              child: classProvider.classStudents.isEmpty
                  ? const Center(child: Text("No students enrolled yet"))
                  : ListView.builder(
                      itemCount: classProvider.classStudents.length,
                      itemBuilder: (context, index) {
                        final student = classProvider.classStudents[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onLongPress: () => showDeleteDialog(
                            currentClass.class_id,
                            student.studid,
                            student.name,
                          ),
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
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      builder: (_) => const AddStudentsSheet(),
    );
  }

  Future<void> showDeleteDialog(int classId, String studid, String name) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Student"),
          content: Text("Are you sure you want to delete $name?"),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xff4F46E5)),
              ),
            ),
            TextButton(
              onPressed: () async {
                final classProvider = context.read<ClassProvider>();

                await classProvider.removeStudentFromClass(classId, studid);

                if (!mounted) return;

                context.pop();

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
