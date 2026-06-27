import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/login_response.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/features/authentication/data/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider({required this.repository});

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
  ) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await repository.signUp(username, email, password, department);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      LoginResponse response = await repository.login(email, password);
      _currentUser = User(username: response.username, email: response.email);
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
      notifyListeners();
      _currentUser = await repository.getUser();
    } catch (e) {
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
}
