import 'package:flutter/material.dart';
import 'package:frontend/core/models/student_model.dart';

class StudentTile extends StatelessWidget {
  final StudentModel student;
  final VoidCallback? onTap;

  const StudentTile({super.key, required this.student, this.onTap});

  static const _colors = [
    Color(0xFF4F46E5),
    Color(0xFF0EA5E9),
    Color(0xFF059669),
    Color(0xFFD97706),
  ];

  Color get _avatarColor =>
      _colors[student.studid.hashCode.abs() % _colors.length];

  String get _initials {
    final parts = student.name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return student.name.isNotEmpty ? student.name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: _avatarColor.withOpacity(0.15),
        child: Text(
          _initials,
          style: TextStyle(
            color: _avatarColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      title: Text(
        student.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color(0xFF1E1B4B),
        ),
      ),
      subtitle: Text(
        student.studid,
        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFF9CA3AF),
        size: 18,
      ),
    );
  }
}
