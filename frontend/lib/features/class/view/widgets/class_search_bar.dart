import 'package:flutter/material.dart';
import 'package:frontend/features/class/providers/class_provider.dart';
import 'package:provider/provider.dart';

class ClassSearchBar extends StatelessWidget {
  final String placeholder;
  const ClassSearchBar({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    final classProvider = context.watch<ClassProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (query) {
          classProvider.get_filtered_classes(query);
        },
        style: const TextStyle(fontSize: 14, color: Color(0xFF1E1B4B)),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF9CA3AF),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
