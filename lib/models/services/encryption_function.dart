import 'dart:io';
import 'dart:isolate';

import 'package:aes_crypt/aes_crypt.dart';

class EncryptionFunctionParamater {
  File inputFile;
  File outputFile;
  AesCrypt aesCrypt;
  SendPort sendPort;

  EncryptionFunctionParamater(
    this.inputFile,
    this.outputFile,
    this.aesCrypt,
    this.sendPort,
  );
}
