import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'image_service.dart';
import '../../constants/colors.dart';

class ImageServiceImpl implements ImageService {
  @override
  Future<File> pickAndCrop() async {
    File image = await pickImage();
    File croppedFile = await crop(image);

    return croppedFile;
  }

  @override
  Future<File> pickImage() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    return File(image.path);
  }

  @override
  Future<File> crop(File image) async {
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

    return croppedFile;
  }
}
