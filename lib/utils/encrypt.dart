import 'dart:async';
import 'dart:io';

import '../models/ui/encFuncParam.dart' as old;
import '../models/services/encryption_function.dart';

Future<void> encryptProfilePhoto(
  old.EncryptionFunctionParameter encFuncParam,
) async {
  await File(encFuncParam.pfpPath).writeAsBytes(
    await encFuncParam.file.readAsBytes(),
  );

  await encFuncParam.crypt.encryptFile(
    encFuncParam.file.path,
    encFuncParam.encPath,
  );

  encFuncParam.sendPort.send(true);
}

Future<void> encryptFile(EncryptionFunctionParamater params) async {
  await params.aesCrypt.encryptFile(
    params.inputFile.path,
    params.outputFile.path,
  );

  params.sendPort.send(true);
}
