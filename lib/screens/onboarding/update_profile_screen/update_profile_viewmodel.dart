import 'dart:io';

import 'package:flutter/material.dart';

import '../../../services/locator.dart';
import '../../../services/accounts/accounts_service.dart';
import '../../../services/image/image_service.dart';

class UpdateProfileViewModel extends ChangeNotifier {
  File _profilePhoto;
  File get profilePhoto => _profilePhoto;

  String _name = "";
  String get name => _name;

  bool _isButtonVisible = false;
  bool get isButtonVisible => _isButtonVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setName(String name) {
    _name = name;

    notifyListeners();

    if (name.isNotEmpty &&
        RegExp(
          r"^[A-z0-9]{4,}.*$|^[A-z0-9]{2,3} [A-z0-9]{2,}.*$",
        ).hasMatch(name)) {
      setButtonVisible(true);
    } else {
      setButtonVisible(false);
    }
  }

  setButtonVisible(bool visible) {
    _isButtonVisible = visible;

    notifyListeners();
  }

  setProfilePhoto(File photo) {
    _profilePhoto = photo;

    notifyListeners();
  }

  updateProfile() async {
    _isLoading = true;
    notifyListeners();

    AccountsService accountsService = locator<AccountsService>();
    await accountsService.initializeProfile(name, profilePhoto);

    _isLoading = false;
    notifyListeners();
  }

  pickPhoto() async {
    try {
      File croppedFile = await locator<ImageService>().pickAndCrop();

      setProfilePhoto(croppedFile);
    } catch (e) {}
  }
}
