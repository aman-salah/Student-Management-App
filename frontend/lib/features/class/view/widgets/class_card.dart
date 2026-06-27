import 'package:flutter/material.dart';
import 'package:frontend/features/class/providers/class_provider.dart';
import 'package:frontend/features/class/view/screens/class_detail_screen.dart';
import 'package:provider/provider.dart';

class ClassCard extends StatelessWidget {
  final int index;

  const ClassCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final classProvider = context.watch<ClassProvider>();
    return GestureDetector(
      onTap: () {
        classProvider.setSelectedClass(classProvider.classes[index]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassDetailScreen(index: index),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (classProvider.classes[index].subject[0] +
                            classProvider.classes[index].subject[1])
                        .toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFF4F46E5),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red[200]),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Subject
            Text(
              classProvider.filteredClasses[index].subject,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1B4B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${classProvider.filteredClasses[index].class_name} • Semester ${classProvider.filteredClasses[index].semester}',
              style: TextStyle(fontSize: 13, color: Colors.grey[500]),
            ),
            const SizedBox(height: 14),
            // Bottom row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${classProvider.classStudents.length} Students',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF9CA3AF),
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
