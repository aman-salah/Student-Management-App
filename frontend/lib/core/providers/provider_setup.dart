import 'package:frontend/core/Theme/theme_provider.dart';
import 'package:frontend/features/authentication/data/auth_repository.dart';
import 'package:frontend/features/authentication/data/auth_service.dart';
import 'package:frontend/features/authentication/providers/auth_provider.dart';
import 'package:frontend/features/mentor/class/data/class_repository.dart';
import 'package:frontend/features/mentor/class/data/class_service.dart';
import 'package:frontend/features/mentor/class/providers/class_provider.dart';
import 'package:frontend/features/mentor/dashboard/data/dashboard_repository.dart';
import 'package:frontend/features/mentor/dashboard/data/dashboard_service.dart';
import 'package:frontend/features/mentor/dashboard/providers/dashboard_provider.dart';
import 'package:frontend/features/mentor/profile/data/profile_repository.dart';
import 'package:frontend/features/mentor/profile/data/profile_service.dart';
import 'package:frontend/features/mentor/profile/providers/profile_provider.dart';
import 'package:frontend/features/mentor/students/data/student_repository.dart';
import 'package:frontend/features/mentor/students/data/student_service.dart';
import 'package:frontend/features/mentor/students/providers/student_provider.dart';
import 'package:frontend/features/student/class/data/student_class_repository.dart';
import 'package:frontend/features/student/class/data/student_class_service.dart';
import 'package:frontend/features/student/class/providers/student_class_provider.dart';
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

    final studentClassService = StudentClassService();
    final studentClassRepository = StudentClassRepository(
      service: studentClassService,
    );
    return [
      ChangeNotifierProvider(
        create: (_) {
          final provider = AuthProvider(repository: authRepository);

          provider.loadUser();

          return provider;
        },
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
      ChangeNotifierProvider(
        create: (_) => StudentClassProvider(repository: studentClassRepository),
      ),
    ];
  }
}
