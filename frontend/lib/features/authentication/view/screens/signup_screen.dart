import 'package:flutter/material.dart';

import 'package:frontend/features/authentication/providers/auth_provider.dart';

import 'package:frontend/features/authentication/view/widgets/my_button.dart';
import 'package:frontend/features/authentication/view/widgets/my_textfield.dart';
import 'package:frontend/features/authentication/view/widgets/role_selector.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final emailController = TextEditingController();
  String selectedDepartment = "CSE";
  final departments = const [
    DropdownMenuItem(value: "CSE", child: Text("CSE")),
    DropdownMenuItem(value: "MECH", child: Text("MECH")),
    DropdownMenuItem(value: "ECE", child: Text("ECE")),
    DropdownMenuItem(value: "EEE", child: Text("EEE")),
    DropdownMenuItem(value: "AI", child: Text("AI")),
  ];
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  //signup user method
  Future<void> signUp(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();

    await authProvider.signUp(
      usernameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      selectedDepartment,
      authProvider.selectedRole,
    );
    if (authProvider.errorMessage == null && mounted) {
      context.go('/login');
    }
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
                SizedBox(height: 20),

                //welcome back message
                Text(
                  "Let's create an account for you",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                RoleSelector(
                  selectedRole: authProvider.selectedRole,
                  onChanged: (role) {
                    authProvider.setSelectedRole(role);
                  },
                ),
                SizedBox(height: 20),
                //username textfield
                MyTextfield(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),
                SizedBox(height: 20),

                //email textfield
                MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                SizedBox(height: 20),

                //password
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: departments,
                    onChanged: (value) {
                      setState(() {
                        selectedDepartment = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                //signUp button
                MyButton(
                  onTap: authProvider.isLoading ? null : () => signUp(context),
                  buttonText: authProvider.isLoading ? "Loading..." : "Sign Up",
                ),
                SizedBox(height: 20),

                //already a member signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a memeber?",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    SizedBox(width: 7),
                    GestureDetector(
                      onTap: () {
                        context.go('/login');
                      },
                      child: Text(
                        "Login now",
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
