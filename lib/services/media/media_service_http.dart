import 'dart:io';

import 'package:dio/dio.dart';

import 'media_service.dart';
import '../locator.dart';
import '../file_encryption/file_encryption_service.dart';
import '../../constants/api.dart';

class MediaServiceHttp implements MediaService {
  @override
  Future<String> uploadMedia(
      File file, String encryptionKey, String authKey) async {
    File outputFile = File(file.path + '.aes');

    FileEncryptionService fileEncryptionService =
        locator<FileEncryptionService>();
    await fileEncryptionService.encryptFile(
      file,
      outputFile,
      encryptionKey,
    );

    Dio dio = locator<Dio>();
    Response response = await dio.post(
      "$mediaUrl/upload",
      data: FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(
            outputFile.path,
            filename: "pfp",
          ),
        },
      ),
      options: Options(
        headers: {
          "Authorization": authKey,
        },
      ),
    );

    return response.data;
  }
}
