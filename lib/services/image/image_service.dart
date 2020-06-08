import 'dart:io';

abstract class ImageService {
  Future<File> pickImage();
  Future<File> pickAndCrop();
  Future<File> crop(File image);
}
