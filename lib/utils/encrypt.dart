import '../models/services/encryption_function.dart';

Future<void> encryptFile(EncryptionFunctionParamater params) async {
  await params.aesCrypt.encryptFile(
    params.inputFile.path,
    params.outputFile.path,
  );

  params.sendPort.send(true);
}
