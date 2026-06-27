import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';

import 'package:frontend/features/authentication/view/widgets/my_button.dart';
import 'package:frontend/features/authentication/view/widgets/my_textfield.dart';
import 'package:frontend/features/authentication/view/widgets/square_tile.dart';
import 'package:frontend/features/authentication/view/screens/signup_screen.dart';
import 'package:frontend/main_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> login() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (authProvider.isLoggedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainScreen()),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                SizedBox(height: 50),
                SafeArea(child: Icon(Icons.lock, size: 80)),
                SizedBox(height: 50),

                //welcome back message
                Text(
                  "Welcome back you've been missed",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 50),

                //email textfield
                MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                SizedBox(height: 20),

                //password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 20),

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (authProvider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      authProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                //signin button
                MyButton(
                  onTap: authProvider.isLoading ? null : login,
                  buttonText: authProvider.isLoading ? "Loading..." : "Sign In",
                ),
                SizedBox(height: 40),

                //continue with google or apple
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //google or apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'assets/images/google.png'),
                    SizedBox(width: 10),
                    SquareTile(imagePath: 'assets/images/apple.png'),
                  ],
                ),
                SizedBox(height: 20),

                //not a member signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a memeber?",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    SizedBox(width: 7),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
