import 'dart:io';
import 'dart:isolate';

import 'package:aes_crypt/aes_crypt.dart';

class EncFuncParam {
  AesCrypt crypt;
  File file;
  SendPort sendPort;
  String pfpPath;
  String encPath;

  EncFuncParam({
    this.file,
    this.crypt,
    this.sendPort,
    this.encPath,
    this.pfpPath,
  });
}
