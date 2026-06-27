import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';
import 'package:frontend/features/authentication/view/screens/login_screen.dart';
import 'package:frontend/main_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkAuth() async {
    print("CHECK AUTH CALLED");
    final authProvider = context.read<AuthProvider>();

    await authProvider.loadUser();
    print("isLoggedIn: ${authProvider.isLoggedIn}");
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            authProvider.isLoggedIn ? const MainScreen() : const LoginScreen(),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    print("SPLASH INIT");
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
