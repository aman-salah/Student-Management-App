import 'package:flutter/material.dart';
import 'package:frontend/features/mentor/class/view/widgets/class_search_bar.dart';
import 'package:frontend/features/student/class/providers/student_class_provider.dart';
import 'package:frontend/features/student/class/view/widgets/student_class_card.dart';
import 'package:provider/provider.dart';

class StudentClassScreen extends StatefulWidget {
  const StudentClassScreen({super.key});

  @override
  State<StudentClassScreen> createState() => _StudentClassScreenState();
}

class _StudentClassScreenState extends State<StudentClassScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StudentClassProvider>().getAllClasses();
    });
  }

  /* void _openCreateSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateClassSheet(),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final studentClassProvider = context.watch<StudentClassProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0F8),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
          ),
        ),
        title: const Text(
          'F I S A T',
          style: TextStyle(
            color: Color(0xFF4F46E5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF4F46E5),
            ),
            onPressed: () {},
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        onPressed: _openCreateSheet,
        child: const Icon(Icons.add),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClassSearchBar(placeholder: 'Search classes...'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CLASSES (${studentClassProvider.classes.length})',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 1.1,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF4F46E5).withOpacity(0.2),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 14,
                          color: Color(0xFF4F46E5),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: studentClassProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : studentClassProvider.errorMessage != null
                  ? Center(child: Text(studentClassProvider.errorMessage!))
                  : ListView.separated(
                      itemCount: studentClassProvider.filteredClasses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (ctx, i) {
                        return StudentClassCard(index: i);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
