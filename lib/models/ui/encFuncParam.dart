import 'dart:io';
import 'dart:isolate';

import 'package:aes_crypt/aes_crypt.dart';

class EncryptionFunctionParameter {
  AesCrypt crypt;
  File file;
  SendPort sendPort;
  String pfpPath;
  String encPath;

  EncryptionFunctionParameter({
    this.file,
    this.crypt,
    this.sendPort,
    this.encPath,
    this.pfpPath,
  });
}
