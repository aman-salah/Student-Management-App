import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const routes = [
      '/mentor/dashboard',
      '/mentor/students',
      '/mentor/class',
      '/mentor/profile',
    ];
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = 0;

    if (location.startsWith('/mentor/dashboard')) {
      currentIndex = 0;
    } else if (location.startsWith('/mentor/students')) {
      currentIndex = 1;
    } else if (location.startsWith('/mentor/class')) {
      currentIndex = 2;
    } else if (location.startsWith('/mentor/profile')) {
      currentIndex = 3;
    }

    return Scaffold(
      body: child,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: const Color(0xFFF0F0F8),

        onTap: (index) {
          context.go(routes[index]);
        },

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
