import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final String info;
  const ProfileInfoCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 140,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 136, 101, 244),
      ),
      child: Center(
        child: Text(info, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
