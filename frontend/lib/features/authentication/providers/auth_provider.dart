import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/login_response.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/features/authentication/data/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider({required this.repository});
  String _selectedRole = "student";
  String get selectedRole => _selectedRole;

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoggedIn => _currentUser != null;

  Future<void> signUp(
    String username,
    String email,
    String password,
    String department,
    String role,
  ) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await repository.signUp(username, email, password, department, role);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password, String role) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      LoginResponse response = await repository.login(email, password, role);
      _currentUser = User(
        username: response.username,
        email: response.email,
        role: response.role,
      );
      print(response.role);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUser() async {
    try {
      _isLoading = true;

      debugPrint("AuthProvider: Calling repository.getUser()");

      _currentUser = await repository.getUser();

      debugPrint("AuthProvider: User loaded = ${_currentUser?.username}");
    } catch (e, stackTrace) {
      debugPrint("AuthProvider ERROR: $e");
      debugPrint(stackTrace.toString());

      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await repository.logout();

    _currentUser = null;
    notifyListeners();
  }

  Future<void> setSelectedRole(String role) async {
    _selectedRole = role;
    notifyListeners();
  }
}
