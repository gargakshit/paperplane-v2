import 'dart:io';

import 'package:flutter/material.dart';

import '../../../services/locator.dart';
import '../../../services/accounts/accounts_service.dart';

class UpdateProfileViewModel extends ChangeNotifier {
  File _profilePhoto;
  File get profilePhoto => _profilePhoto;

  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  bool _isButtonVisible = false;
  bool get isButtonVisible => _isButtonVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  init() {
    _nameController.addListener(() {
      if (_nameController.text.isNotEmpty) {
        _isButtonVisible = true;
      } else {
        _isButtonVisible = false;
      }

      notifyListeners();
    });
  }

  setProfilePhoto(File photo) {
    _profilePhoto = photo;

    notifyListeners();
  }

  updateProfile() async {
    _isLoading = true;
    notifyListeners();

    AccountsService accountsService = locator<AccountsService>();
    await accountsService.initializeProfile(_nameController.text, profilePhoto);

    _isLoading = false;
    notifyListeners();
  }
}
