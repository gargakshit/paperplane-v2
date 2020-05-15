import 'dart:async';
import 'dart:io';

import 'package:paperplane/models/ui/encFuncParam.dart';

FutureOr<void> encryptProfilePhoto(EncFuncParam encFuncParam) async {
  await File(encFuncParam.pfpPath).writeAsBytes(
    await encFuncParam.file.readAsBytes(),
  );

  await encFuncParam.crypt.encryptFile(
    encFuncParam.file.path,
    encFuncParam.encPath,
  );

  encFuncParam.sendPort.send(true);
}
