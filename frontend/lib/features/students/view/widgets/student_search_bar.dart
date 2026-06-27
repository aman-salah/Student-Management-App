import 'package:flutter/material.dart';
import 'package:frontend/features/students/providers/student_provider.dart';
import 'package:provider/provider.dart';

class StudentSearchBar extends StatelessWidget {
  final String placeholder;

  const StudentSearchBar({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          prefixIcon: const Icon(Icons.search, color: Color(0xff9CA3AF)),

          hintText: placeholder,

          hintStyle: const TextStyle(
            color: Color(0xff9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),

          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
        onChanged: (query) {
          studentProvider.get_filtered_students(query);
        },
      ),
    );
  }
}
