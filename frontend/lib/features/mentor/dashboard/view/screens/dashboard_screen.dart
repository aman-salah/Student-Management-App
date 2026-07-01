import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';
import 'package:frontend/features/mentor/dashboard/providers/dashboard_provider.dart';
import 'package:frontend/features/mentor/dashboard/view/widgets/dashboard_stat_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final authProvider = context.watch<AuthProvider>();
    debugPrint("Dashboard user: ${authProvider.currentUser?.username}");

    final user = authProvider.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0F8),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
          ),
        ),
        title: const Text(
          'D A S H B O A R D',
          style: TextStyle(
            color: Color(0xff4F46E5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xff4F46E5),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 145,
              decoration: BoxDecoration(
                color: const Color.fromARGB(230, 120, 86, 255),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(87, 0, 0, 0),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Text(
                      'Welcome, ${user.username}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
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

            const SizedBox(height: 25),

            Row(
              children: [
                DashboardStatCard(
                  title: 'Students',
                  count: dashboardProvider.stats?.totalStudents ?? 0,
                  icon: Icons.person,
                  color: Colors.white,
                  cardColor: const Color.fromARGB(255, 190, 126, 254),
                ),

                const SizedBox(width: 15),

                DashboardStatCard(
                  title: 'Classes',
                  count: dashboardProvider.stats?.totalClasses ?? 0,
                  icon: Icons.class_,
                  color: Colors.white,
                  cardColor: const Color.fromARGB(255, 121, 212, 153),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
