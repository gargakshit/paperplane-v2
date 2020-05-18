import 'dart:io';

abstract class MediaService {
  Future<String> uploadMedia(File file, String encryptionKey, String authKey);
}
