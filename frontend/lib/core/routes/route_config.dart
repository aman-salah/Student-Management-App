import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/view/screens/login_screen.dart';
import 'package:frontend/features/authentication/view/screens/signup_screen.dart';
import 'package:frontend/features/mentor/class/view/screens/class_detail_screen.dart';
import 'package:frontend/features/mentor/class/view/screens/class_screen.dart';
import 'package:frontend/features/mentor/dashboard/view/screens/dashboard_screen.dart';
import 'package:frontend/features/mentor/profile/view/screens/profile_screen.dart';
import 'package:frontend/features/mentor/students/view/screens/student_screen.dart';
import 'package:frontend/features/mentor/main_screen.dart';
import 'package:frontend/features/student/attendance/view/student_attendance_screen.dart';
import 'package:frontend/features/student/class/view/screens/student_class_details_screen.dart';
import 'package:frontend/features/student/class/view/screens/student_class_screen.dart';
import 'package:frontend/features/student/dashboard/view/student_dashboard_screen.dart';
import 'package:frontend/features/student/student_main_screen.dart';
import 'package:frontend/splash_screen.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        },
      ),

      GoRoute(
        name: 'login',
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignupScreen());
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/mentor/dashboard',
            builder: (context, state) => DashboardScreen(),
          ),
          GoRoute(
            path: '/mentor/students',
            builder: (context, state) => StudentScreen(),
          ),
          GoRoute(
            path: '/mentor/class',
            builder: (context, state) => ClassScreen(),
            routes: [
              GoRoute(
                path: ':classId',
                builder: (context, state) {
                  final classId = state.pathParameters['classId']!;
                  return ClassDetailScreen(classId: classId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/mentor/profile',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return StudentMainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/student/dashboard',
            builder: (context, state) => StudentDashboardScreen(),
          ),
          GoRoute(
            path: '/student/attendance',
            builder: (context, state) => StudentAttendanceScreen(),
          ),
          GoRoute(
            path: '/student/class',
            builder: (context, state) => StudentClassScreen(),
            routes: [
              GoRoute(
                path: ':classId',
                builder: (context, state) {
                  final classId = state.pathParameters['classId']!;
                  return StudentClassDetailsScreen(classId: classId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/student/profile',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
