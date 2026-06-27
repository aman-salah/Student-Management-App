import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';
import 'package:frontend/features/class/view/screens/class_screen.dart';
import 'package:frontend/features/dashboard/view/screens/dashboard_screen.dart';
import 'package:frontend/features/profile/view/screens/profile_screen.dart';
import 'package:frontend/features/students/view/screens/student_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      const DashboardScreen(),
      const StudentScreen(),
      const ClassScreen(),
      const ProfileScreen(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AuthProvider>();

    return Scaffold(
      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF0F0F8),
        currentIndex: selectedIndex,
        onTap: onItemTapped,

        selectedItemColor: const Color(0xff4F46E5),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: "Students",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: "Class",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
