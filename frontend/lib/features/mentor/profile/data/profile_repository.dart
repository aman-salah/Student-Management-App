import 'package:frontend/core/models/profile_model.dart';
import 'package:frontend/features/mentor/profile/data/profile_service.dart';

class ProfileRepository {
  final ProfileService service;

  ProfileRepository({required this.service});

  Future<ProfileModel> getProfile() {
    return service.getProfile();
  }
}
