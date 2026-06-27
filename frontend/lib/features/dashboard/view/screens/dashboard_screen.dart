import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';

import 'package:frontend/features/dashboard/providers/dashboard_provider.dart';
import 'package:frontend/features/dashboard/view/widgets/dashboard_stat_card.dart';

import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<DashboardProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final authProvider = context.watch<AuthProvider>();
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
          'D A S H B O A R D',
          style: TextStyle(
            color: Color(0xff4F46E5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 145,
              decoration: BoxDecoration(
                color: const Color.fromARGB(230, 120, 86, 255),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(87, 0, 0, 0),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Welcome , ${authProvider.currentUser!.username}!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Here is a quick overview of your institutional details.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(248, 220, 220, 224),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                DashboardStatCard(
                  title: 'Students',
                  count: dashboardProvider.stats?.totalStudents ?? 0,
                  icon: Icons.person,
                  color: Colors.white,
                  cardColor: const Color.fromARGB(255, 190, 126, 254),
                ),
                SizedBox(width: 15),
                DashboardStatCard(
                  title: 'Classes',
                  count: dashboardProvider.stats?.totalClasses ?? 0,
                  icon: Icons.class_,
                  color: Colors.white,
                  cardColor: const Color.fromARGB(255, 121, 212, 153),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
