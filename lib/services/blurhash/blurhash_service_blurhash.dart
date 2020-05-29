import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart';

import 'blurhash_service.dart';
import '../../models/services/blurhash_function.dart';
import '../../utils/generate_blurhash.dart';

class BlurHashServiceBlurHash extends BlurHashService {
  @override
  Future<String> encode(
    Uint8List data,
    int width,
    int height, {
    int numCompX: 4,
    int numCompY: 3,
  }) async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(
      generateBlurHash,
      BlurHashFunctionParameter(
        data,
        width,
        height,
        receivePort.sendPort,
        numCompX: numCompX,
        numCompY: numCompY,
      ),
    );

    return await receivePort.first;
  }

  @override
  Future<String> encodeFile(
    File file, {
    int numCompX: 4,
    int numCompY: 3,
  }) async {
    Uint8List data = file.readAsBytesSync();
    Image image = decodeImage(data.toList());

    return await encode(
      image.getBytes(format: Format.rgba),
      image.width,
      image.height,
      numCompX: numCompX,
      numCompY: numCompY,
    );
  }
}
