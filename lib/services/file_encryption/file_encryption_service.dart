import 'dart:io';

abstract class FileEncryptionService {
  Future<void> encryptFile(
    File inputFile,
    File outputFile,
    String password,
  );
}
