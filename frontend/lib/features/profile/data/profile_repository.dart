import 'package:frontend/core/models/profile_model.dart';
import 'package:frontend/features/profile/data/profile_service.dart';

class ProfileRepository {
  final ProfileService service;

  ProfileRepository({required this.service});

  Future<ProfileModel> getProfile() {
    return service.getProfile();
  }
}
