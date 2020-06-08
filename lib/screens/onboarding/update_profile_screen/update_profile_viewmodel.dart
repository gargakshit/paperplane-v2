import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';
import '../../../services/locator.dart';
import '../../../services/accounts/accounts_service.dart';

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
      final PickedFile image = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );

      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressFormat: ImageCompressFormat.png,
        maxHeight: 512,
        maxWidth: 512,
        compressQuality: 100,
        cropStyle: CropStyle.rectangle,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Crop",
          toolbarColor: canvasColorDark,
          activeControlsWidgetColor: primaryColorLight,
          toolbarWidgetColor: Colors.white,
          statusBarColor: canvasColorDark,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          backgroundColor: canvasColorDark,
          dimmedLayerColor: canvasColorDark,
          cropFrameStrokeWidth: 8,
          cropGridStrokeWidth: 6,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          showCancelConfirmationDialog: true,
        ),
      );

      setProfilePhoto(croppedFile);
    } catch (e) {}
  }
}
