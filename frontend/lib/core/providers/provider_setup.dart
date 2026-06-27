import 'package:frontend/core/Theme/theme_provider.dart';
import 'package:frontend/features/authentication/data/auth_repository.dart';
import 'package:frontend/features/authentication/data/auth_service.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';
import 'package:frontend/features/class/data/class_repository.dart';
import 'package:frontend/features/class/data/class_service.dart';
import 'package:frontend/features/class/providers/class_provider.dart';
import 'package:frontend/features/dashboard/data/dashboard_repository.dart';
import 'package:frontend/features/dashboard/data/dashboard_service.dart';
import 'package:frontend/features/dashboard/providers/dashboard_provider.dart';
import 'package:frontend/features/profile/data/profile_repository.dart';
import 'package:frontend/features/profile/data/profile_service.dart';
import 'package:frontend/features/profile/providers/profile_provider.dart';
import 'package:frontend/features/students/data/student_repository.dart';
import 'package:frontend/features/students/data/student_service.dart';
import 'package:frontend/features/students/providers/student_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//this file keeps all providers as list so the main.dart just use this list in multiprovider to make it look clean

class ProviderSetup {
  static List<SingleChildWidget> get providers {
    final authService = AuthService();
    final authRepository = AuthRepository(service: authService);

    final studentService = StudentService();
    final studentRepository = StudentRepository(service: studentService);

    final classService = ClassService();
    final classRepository = ClassRepository(service: classService);

    final dashboardService = DashboardService();
    final dashboardRepository = DashboardRepository(service: dashboardService);

    final profileService = ProfileService();
    final profileRepository = ProfileRepository(service: profileService);
    return [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(repository: authRepository),
      ),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(
        create: (_) => StudentProvider(repository: studentRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => ClassProvider(repository: classRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => DashboardProvider(repository: dashboardRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => ProfileProvider(repository: profileRepository),
      ),
    ];
  }
}
