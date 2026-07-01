import 'package:flutter/material.dart';
import 'package:frontend/core/models/dashboard_model.dart';
import 'package:frontend/features/mentor/dashboard/data/dashboard_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository repository;

  DashboardProvider({required this.repository});

  DashboardModel? _stats;
  DashboardModel? get stats => _stats;

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> loadDashboard() async {
    try {
      _isLoading = true;
      notifyListeners();

      _stats = await repository.getDashboardStats();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
