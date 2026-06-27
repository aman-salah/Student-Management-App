import 'package:frontend/core/models/login_response.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/core/shared_preferences.dart';
import 'package:frontend/features/authentication/data/auth_service.dart';

class AuthRepository {
  final AuthService service;

  AuthRepository({required this.service});

  Future<User> signUp(
    String username,
    String email,
    String password,
    String department,
  ) {
    return service.signUp(username, email, password, department);
  }

  Future<LoginResponse> login(String email, String password) async {
    final response = await service.login(email, password);
    await TokenStorage.saveToken(response.accessToken);
    return response;
  }

  Future<User> getUser() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception("No token");
    } else {
      return service.getUser(token);
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearToken();
  }
}
