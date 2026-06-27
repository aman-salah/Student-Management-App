import 'package:frontend/core/models/dashboard_model.dart';
import 'package:frontend/features/dashboard/data/dashboard_service.dart';

class DashboardRepository {
  final DashboardService service;

  DashboardRepository({required this.service});

  Future<DashboardModel> getDashboardStats() {
    return service.getDashboardStats();
  }
}
