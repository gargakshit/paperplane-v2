import 'dart:io';
import 'dart:isolate';

import 'package:aes_crypt/aes_crypt.dart';

import 'file_encryption_service.dart';
import '../../models/services/encryption_function.dart';
import '../../utils/encrypt.dart' as utils;

class FileEncryptionServiceAesCrypt extends FileEncryptionService {
  @override
  Future<void> encryptFile(
    File inputFile,
    File outputFile,
    String password,
  ) async {
    AesCrypt aesCrypt = AesCrypt(password);
    aesCrypt.setOverwriteMode(AesCryptOwMode.on);

    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(
      utils.encryptFile,
      EncryptionFunctionParamater(
        inputFile,
        outputFile,
        aesCrypt,
        receivePort.sendPort,
      ),
    );
    await receivePort.first;
  }
}
