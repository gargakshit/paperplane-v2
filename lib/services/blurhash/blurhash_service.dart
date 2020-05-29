import 'dart:io';
import 'dart:typed_data';

abstract class BlurHashService {
  Future<String> encode(
    Uint8List data,
    int width,
    int height, {
    int numCompX: 4,
    int numCompY: 3,
  });
  Future<String> encodeFile(
    File file, {
    int numCompX: 4,
    int numCompY: 3,
  });
}
