import 'package:flutter/material.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final Color cardColor;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(87, 0, 0, 0),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, color: color, size: 24),
            ),

            const Spacer(),

            Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
