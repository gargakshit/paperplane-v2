import 'dart:isolate';
import 'dart:typed_data';

class BlurHashFunctionParameter {
  Uint8List data;
  int width;
  int height;
  SendPort sendPort;
  int numCompX = 4;
  int numCompY = 3;

  BlurHashFunctionParameter(
    this.data,
    this.width,
    this.height,
    this.sendPort, {
    this.numCompX,
    this.numCompY,
  });
}
