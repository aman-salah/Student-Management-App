import 'package:flutter/material.dart';
import 'package:frontend/core/models/profile_model.dart';
import 'package:frontend/features/mentor/profile/data/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository;

  ProfileProvider({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  Future<void> getProfile() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _profile = await repository.getProfile();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
